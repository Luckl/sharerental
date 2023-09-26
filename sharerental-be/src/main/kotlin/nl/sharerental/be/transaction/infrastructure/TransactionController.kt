package nl.sharerental.be.transaction.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.transaction.Transaction
import nl.sharerental.be.transaction.TransactionStatus
import nl.sharerental.be.transaction.infrastructure.repository.TransactionRepository
import nl.sharerental.be.transaction.mollie.TransactionProcessor
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.be.user.configuration.RequestResponseLoggingInterceptor
import nl.sharerental.contract.http.TransactionApi
import nl.sharerental.contract.http.model.CreateTransactionRequest
import nl.sharerental.contract.http.model.CreateTransactionResponse
import nl.sharerental.contract.http.model.TransactionCalculationInput
import nl.sharerental.contract.http.model.TransactionCalculationResult
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
                    transactionCalculationInput.endDate
                )
            }
            .map { ResponseEntity.ok(TransactionCalculationResult(it)) }
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }
    }

    override fun mollieCallback(id: String?): ResponseEntity<Void> {
        logger.info("Received mollie webhook call for mollie payment reference {}", id)
        return ResponseEntity.ok().build()
    }

    @Transactional
    override fun startTransaction(createTransactionRequest: CreateTransactionRequest?): ResponseEntity<CreateTransactionResponse> {
        val rentalItem = rentalItemRepository.findById(createTransactionRequest!!.rentalItemId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }

        val price =
            Transaction.calculatePrice(rentalItem, createTransactionRequest.startDate, createTransactionRequest.endDate)

        logger.info("Creating transaction for rentalItem {} at price {} from {} to {}", rentalItem.id, price, createTransactionRequest.startDate, createTransactionRequest.endDate)

        val transaction = Transaction(
            rentalItem = rentalItem,
            renter = currentUserService.get(),
            startDate = createTransactionRequest.startDate,
            endDate = createTransactionRequest.endDate,
            price = price
        )

        val currentStatus = TransactionStatus(
            transaction = transaction
        )

        transaction.currentStatus = currentStatus

        val savedTransaction = transactionRepository.save(transaction)

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