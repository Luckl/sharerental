package nl.sharerental.be.transaction.infrastructure

import be.woutschoovaerts.mollie.data.payment.PaymentStatus
import jakarta.transaction.Transactional
import nl.sharerental.be.infrastructure.PageableHelper
import nl.sharerental.be.lessor.infrastructure.repository.LessorRepository
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.transaction.Transaction
import nl.sharerental.be.transaction.TransactionService
import nl.sharerental.be.transaction.TransactionStatus
import nl.sharerental.be.transaction.TransactionStatusEnum
import nl.sharerental.be.transaction.infrastructure.repository.TransactionRepository
import nl.sharerental.be.transaction.mollie.TransactionProcessor
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.be.user.infrastructure.onesignal.OneSignalEmailSender
import nl.sharerental.contract.http.TransactionApi
import nl.sharerental.contract.http.model.*
import nl.sharerental.contract.http.model.TransactionStatus as HttpTransactionStatus
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException
import kotlin.math.max

@RestController
class TransactionController(
    private val rentalItemRepository: RentalItemRepository,
    private val transactionProcessor: TransactionProcessor,
    private val currentUserService: CurrentUserService,
    private val transactionRepository: TransactionRepository,
    private val transactionService: TransactionService,
    private val lessorRepository: LessorRepository,
    private val oneSignalEmailSender: OneSignalEmailSender,
) : TransactionApi {

    private val logger: Logger = LoggerFactory.getLogger(TransactionController::class.java)

    override fun calculatePrice(transactionCalculationInput: TransactionCalculationInput?): ResponseEntity<TransactionCalculationResult> {
        transactionCalculationInput ?: ResponseStatusException(HttpStatus.BAD_REQUEST)

        return rentalItemRepository.findById(transactionCalculationInput!!.rentalItemId)
            .map {
                Transaction.calculatePrice(
                    it,
                    transactionCalculationInput.startDate,
                    transactionCalculationInput.endDate,
                    transactionCalculationInput.amount
                )
            }
            .map { ResponseEntity.ok(TransactionCalculationResult(it)) }
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }
    }

    @Transactional
    override fun mollieCallback(id: String?): ResponseEntity<Void> {
        logger.info("Received mollie webhook call for mollie payment reference {}", id)

        id ?: ResponseStatusException(HttpStatus.BAD_REQUEST)
        val molliePaymentStatus = transactionProcessor.getMolliePaymentStatus(id)

        logger.info("Received status {} for mollie payment reference {}", molliePaymentStatus, id)

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
            oneSignalEmailSender.sendItemRentedEmail(transaction)
        }

        return ResponseEntity.ok().build()
    }

    override fun getTransactions(
        @RequestParam(defaultValue = "0", required = false, value = "page") page: Int?,
        @RequestParam(defaultValue = "8", required = false, value = "size") size: Int?,
        @RequestParam(required = false, value = "sort") sort: MutableList<String>?,
        @RequestParam(required = false, value = "filter") filter: String?,
        @RequestParam(
            required = false,
            value = "status"
        ) status: MutableList<nl.sharerental.contract.http.model.TransactionStatus>?
    ): ResponseEntity<GetTransactionsResult>? {
        val lessors = lessorRepository.getIdsForUserId(currentUserService.get().id)

        if (lessors.size != 1) {
            throw RuntimeException("Multiple or no lessors for user, cannot find transactions.")
        }

        val actualSort = if (sort?.isEmpty() == true) mutableListOf("startDate;desc") else sort

        status?.map { it.toEntityEnum() } ?: listOf(TransactionStatusEnum.ACCEPTED, TransactionStatusEnum.PAID, TransactionStatusEnum.COMPLETED)

        val findAll = transactionRepository.findByLessorIdAndSearch(
            lessors[0],
            filter,
            status?.map { it.toEntityEnum() }.orEmpty(),
            PageableHelper.pageRequest(page, size, actualSort)
        )

        val getTransactionsResult = GetTransactionsResult(
            findAll.content.map { it.toResponse() },
            PaginationResponse(findAll.totalElements, findAll.totalPages, findAll.number)
        )

        return ResponseEntity.ok(getTransactionsResult)
    }

    override fun getAmountAvailableForDate(getAmountAvailableRequest: GetAmountAvailableRequest?): ResponseEntity<GetAmountAvailableResponse> {
        val rentalItem = rentalItemRepository.findById(getAmountAvailableRequest!!.rentalItemId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }

        val amountRentedOut = transactionService.getAmountOfRentedOutItems(
            rentalItem,
            getAmountAvailableRequest.startDate,
            getAmountAvailableRequest.endDate
        )

        return ResponseEntity.ok(GetAmountAvailableResponse(max(rentalItem.amount - amountRentedOut, 0)))
    }

    @Transactional
    override fun startTransaction(createTransactionRequest: CreateTransactionRequest?): ResponseEntity<CreateTransactionResponse> {
        val rentalItem = rentalItemRepository.findById(createTransactionRequest!!.rentalItemId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }

        if (transactionService.getAmountOfRentedOutItems(
                rentalItem,
                createTransactionRequest.startDate,
                createTransactionRequest.endDate
            ) + createTransactionRequest.amount > rentalItem.amount
        ) {
            logger.warn("Tried to rent {} items but that many are not available.", createTransactionRequest.amount)
            throw ResponseStatusException(HttpStatus.BAD_REQUEST)
        }

        val price =
            Transaction.calculatePrice(
                rentalItem,
                createTransactionRequest.startDate,
                createTransactionRequest.endDate,
                createTransactionRequest.amount
            )

        logger.info(
            "Creating transaction for rentalItem {} at price {} from {} to {}",
            rentalItem.id,
            price,
            createTransactionRequest.startDate,
            createTransactionRequest.endDate
        )

        val transaction = Transaction(
            rentalItem = rentalItem,
            renter = currentUserService.get(),
            startDate = createTransactionRequest.startDate,
            endDate = createTransactionRequest.endDate,
            amount = createTransactionRequest.amount,
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
            userId = currentUserService.get().id
        )

        savedTransaction.molliePaymentReference = mollieTransaction.molliePaymentReference

        logger.info("Successfully created transaction {}", savedTransaction.id)
        return ResponseEntity.ok(CreateTransactionResponse().redirectUrl(mollieTransaction.checkoutUrl))
    }
}

private fun HttpTransactionStatus.toEntityEnum(): TransactionStatusEnum {
    return when(this) {
        HttpTransactionStatus.INITIALIZED -> TransactionStatusEnum.INITIALIZED
        HttpTransactionStatus.PAID -> TransactionStatusEnum.PAID
        HttpTransactionStatus.ACCEPTED -> TransactionStatusEnum.ACCEPTED
        HttpTransactionStatus.COMPLETED -> TransactionStatusEnum.COMPLETED
        HttpTransactionStatus.PAID_OUT -> TransactionStatusEnum.PAID_OUT
        HttpTransactionStatus.CANCELLED -> TransactionStatusEnum.CANCELLED
    }
}
