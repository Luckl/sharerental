package nl.sharerental.be.transaction.infrastructure

import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.transaction.Transaction
import nl.sharerental.contract.http.TransactionApi
import nl.sharerental.contract.http.model.TransactionCalculationInput
import nl.sharerental.contract.http.model.TransactionCalculationResult
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException

@RestController
class TransactionController(private val rentalItemRepository: RentalItemRepository): TransactionApi {
    override fun calculatePrice(transactionCalculationInput: TransactionCalculationInput?): ResponseEntity<TransactionCalculationResult> {
        transactionCalculationInput ?: ResponseStatusException(HttpStatus.BAD_REQUEST)

        return rentalItemRepository.findById(transactionCalculationInput!!.rentalItemId)
            .map { Transaction.calculatePrice(it, transactionCalculationInput.startDate, transactionCalculationInput.endDate) }
            .map { ResponseEntity.ok(TransactionCalculationResult(it)) }
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }
    }
}