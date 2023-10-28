package nl.sharerental.be.transaction.infrastructure.repository

import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.transaction.Transaction
import nl.sharerental.be.transaction.TransactionStatus
import org.springframework.data.repository.CrudRepository
import java.time.LocalDate
import java.util.*

interface TransactionRepository: CrudRepository<Transaction, Long> {

    fun findByMolliePaymentReference(molliePaymentReference: String?): Optional<Transaction>

    fun findAllByRentalItemAndStartDateAfterAndEndDateBefore(rentalItem: RentalItem, startDate: LocalDate, endDate: LocalDate): List<Transaction>
}