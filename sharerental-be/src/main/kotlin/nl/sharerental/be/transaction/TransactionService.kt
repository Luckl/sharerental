package nl.sharerental.be.transaction

import be.woutschoovaerts.mollie.data.payment.PaymentStatus
import jakarta.transaction.Transactional
import jakarta.validation.constraints.NotNull
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.transaction.infrastructure.repository.TransactionRepository
import nl.sharerental.be.transaction.mollie.TransactionProcessor
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.be.user.Renter
import nl.sharerental.be.user.RenterType
import nl.sharerental.be.user.infrastructure.onesignal.OneSignalEmailSender
import nl.sharerental.contract.http.model.TransactionCalculationInput
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException
import java.math.BigDecimal
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneOffset
import java.time.temporal.ChronoUnit
import java.util.*

@Service
class TransactionService(
    private val transactionRepository: TransactionRepository,
    private val transactionProcessor: TransactionProcessor,
    private val currentUserService: CurrentUserService,
    private val oneSignalEmailSender: OneSignalEmailSender,
    private val rentalItemRepository: RentalItemRepository,
) {

    private val logger: Logger = LoggerFactory.getLogger(TransactionService::class.java)

    /**
     * expires transactions with currentStatus INITIALIZED and currentStatus time is older than 30 minutes
     */
    @Scheduled(cron = "0 * * * * *")
    @Transactional
    fun expireTransactions() {
        logger.debug("Running expireTransactions cronjob")
        val transactions = transactionRepository.findAllByCurrentStatusAndOlderThan(
            TransactionStatusEnum.INITIALIZED,
            LocalDateTime.now().minusMinutes(30).toInstant(
                ZoneOffset.UTC
            )
        )

        transactions.forEach {
            it.currentStatus = TransactionStatus(
                status = TransactionStatusEnum.CANCELLED,
                transaction = it,
                notes = "Transaction expired after 30 minutes"
            )
        }

        if (transactions.isNotEmpty()) {
            logger.info(
                "Expired {} transactions with status INITIALIZED that were older than 30 minutes",
                transactions.size
            )
        }
    }

    fun getAmountOfRentedOutItems(
        rentalItem: RentalItem,
        startDate: @NotNull LocalDate,
        endDate: @NotNull LocalDate
    ): Int {
        val transactions = transactionRepository.findAllByRentalItemAndDateRange(
            rentalItem.id,
            startDate,
            endDate
        ).filter { TransactionStatusEnum.CANCELLED != it.currentStatus?.status }

        return createLocalDateList(startDate, endDate)
            .maxOf { findAmountRentedOnDate(it, transactions) }
    }

    fun findAmountRentedOnDate(date: LocalDate, transactions: List<Transaction>) = transactions
        .filter {
            (it.startDate.isAfter(date) && it.endDate.isBefore(date))
                    || it.startDate.isEqual(date)
                    || it.endDate.isEqual(date)
        }.sumOf { it.amount }

    private fun createLocalDateList(startDate: LocalDate, endDate: LocalDate): List<LocalDate> {
        val dateList = mutableListOf<LocalDate>()
        var currentDate = startDate

        while (!currentDate.isAfter(endDate)) {
            dateList.add(currentDate)
            currentDate = currentDate.plus(1, ChronoUnit.DAYS)
        }

        return dateList
    }

    fun processMollieCallback(id: String) {
        val molliePaymentStatus = transactionProcessor.getMolliePaymentStatus(id)

        logger.debug("Received status {} for mollie payment reference {}", molliePaymentStatus, id)

        val transaction = transactionRepository.findByMolliePaymentReference(id).orElseThrow {
            logger.error("Could not find shareRental transaction related to mollie payment reference {}", id)
            ResponseStatusException(HttpStatus.NOT_FOUND)
        }

        when (molliePaymentStatus) {
            PaymentStatus.PAID -> transaction.currentStatus =
                TransactionStatus(status = TransactionStatusEnum.PAID, transaction = transaction)

            PaymentStatus.CANCELED -> transaction.currentStatus =
                TransactionStatus(status = TransactionStatusEnum.CANCELLED, transaction = transaction)

            PaymentStatus.EXPIRED -> transaction.currentStatus =
                TransactionStatus(status = TransactionStatusEnum.CANCELLED, transaction = transaction)

            PaymentStatus.FAILED -> transaction.currentStatus =
                TransactionStatus(status = TransactionStatusEnum.CANCELLED, transaction = transaction)

            else -> {
                logger.error("Received invalid status from Mollie after webhook.")
            }
        }

        if (molliePaymentStatus == PaymentStatus.PAID) {
            oneSignalEmailSender.sendTransactionSuccessfulEmailToRenter(transaction)

            processTransactionForLessor(transaction)
        }
    }

    fun processTransactionForLessor(transaction: Transaction) {
        oneSignalEmailSender.sendItemRentedEmailToLessor(transaction)
        if (transaction.rentalItem.automaticallyAcceptTransaction) {
            transaction.currentStatus = TransactionStatus(
                status = TransactionStatusEnum.ACCEPTED,
                transaction = transaction
            )
        }
    }

    fun startTransaction(
        rentalItem: RentalItem,
        startDate: LocalDate,
        endDate: LocalDate,
        amount: Int,
        renterOptional: Renter?
    ): String {

        if (getAmountOfRentedOutItems(
                rentalItem,
                startDate,
                endDate
            ) + amount > rentalItem.amount
        ) {
            logger.warn("Tried to rent {} items but that many are not available.", amount)
            throw ResponseStatusException(HttpStatus.BAD_REQUEST)
        }

        val price =
            Transaction.calculatePrice(
                rentalItem,
                startDate,
                endDate,
                amount
            )

        logger.debug(
            "Creating transaction for rentalItem {} at price {} from {} to {}",
            rentalItem.id,
            price,
            startDate,
            endDate
        )

        val user = currentUserService.getOptional()

        val renter = renterOptional ?: user?.renterInformation
            ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST)

        user?.apply {
            this.renterInformation = renter
        }

        val transaction = Transaction(
            rentalItem = rentalItem,
            renter = renter,
            startDate = startDate,
            endDate = endDate,
            amount = amount,
            price = price
        )

        //First save so TransactionStatus entity won't get a null value for transaction_id
        val savedTransaction = transactionRepository.save(transaction)

        val currentStatus = TransactionStatus(
            transaction = savedTransaction
        )

        savedTransaction.currentStatus = currentStatus

        val mollieTransaction = transactionProcessor.initializeTransaction(
            amount = price,
            description = "${savedTransaction.id} - ${rentalItem.name}",
            transactionId = savedTransaction.id,
            userId = user?.id ?: renter.email
        )

        savedTransaction.molliePaymentReference = mollieTransaction.molliePaymentReference

        logger.debug("Successfully created transaction {}", savedTransaction.id)

        return mollieTransaction.checkoutUrl
    }

    fun calculatePrice(transactionCalculationInput: TransactionCalculationInput): Optional<BigDecimal> =
        rentalItemRepository.findById(transactionCalculationInput.rentalItemId)
            .map {
                Transaction.calculatePrice(
                    it,
                    transactionCalculationInput.startDate,
                    transactionCalculationInput.endDate,
                    transactionCalculationInput.amount
                )
            }

}