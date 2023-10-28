package nl.sharerental.be.transaction.infrastructure.repository

import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.transaction.Transaction
import nl.sharerental.be.transaction.TransactionStatus
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import java.time.LocalDate
import java.util.*

interface TransactionRepository: CrudRepository<Transaction, Long> {

    fun findByMolliePaymentReference(molliePaymentReference: String?): Optional<Transaction>

    @Query("""
        select t from Transaction t where t.rentalItem = :rentalItem and 
        ( :startDate <= t.startDate and :endDate >= t.startDate ) or 
        ( :endDate >= t.endDate and :startDate < t.endDate ) or
        ( :startDate >= t.startDate and :endDate <= t.endDate )
    """)
    fun findAllByRentalItemAndDateRange(rentalItem: RentalItem, startDate: LocalDate, endDate: LocalDate): List<Transaction>
}