package nl.sharerental.be.transaction.infrastructure

import be.woutschoovaerts.mollie.data.payment.PaymentStatus
import jakarta.transaction.Transactional
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.transaction.Transaction
import nl.sharerental.be.transaction.TransactionStatus
import nl.sharerental.be.transaction.TransactionStatusEnum
import nl.sharerental.be.transaction.infrastructure.repository.TransactionRepository
import nl.sharerental.be.transaction.mollie.TransactionProcessor
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.contract.http.TransactionApi
import nl.sharerental.contract.http.model.*
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException

@RestController
class TransactionController(
    private val rentalItemRepository: RentalItemRepository,
    private val transactionProcessor: TransactionProcessor,
    private val currentUserService: CurrentUserService,
    private val transactionRepository: TransactionRepository,
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
            PaymentStatus.CANCELED -> transaction.currentStatus = TransactionStatus(status = TransactionStatusEnum.CANCELLED, transaction = transaction)
            PaymentStatus.EXPIRED -> transaction.currentStatus = TransactionStatus(status = TransactionStatusEnum.CANCELLED, transaction = transaction)
            PaymentStatus.FAILED -> transaction.currentStatus = TransactionStatus(status = TransactionStatusEnum.CANCELLED, transaction = transaction)
            else -> {
                logger.error("Received invalid status from Mollie after webhook.")
            }
        }

        // Do things to communicate to lessor

        return ResponseEntity.ok().build()
    }

    override fun getAmountAvailableForDate(getAmountAvailableRequest: GetAmountAvailableRequest?): ResponseEntity<GetAmountAvailableResponse> {
        val rentalItem = rentalItemRepository.findById(getAmountAvailableRequest!!.rentalItemId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }

        //TODO: Calculate based on transactions between that date.
        return ResponseEntity.ok(GetAmountAvailableResponse(rentalItem.amount))
    }

    @Transactional
    override fun startTransaction(createTransactionRequest: CreateTransactionRequest?): ResponseEntity<CreateTransactionResponse> {
        val rentalItem = rentalItemRepository.findById(createTransactionRequest!!.rentalItemId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }

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