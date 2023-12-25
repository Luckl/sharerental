package nl.sharerental.be.transaction.infrastructure.repository

import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.transaction.Transaction
import nl.sharerental.be.transaction.TransactionStatusEnum
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.query.Param
import java.time.LocalDate
import java.util.*

interface TransactionRepository: CrudRepository<Transaction, Long> {

    fun findByMolliePaymentReference(molliePaymentReference: String?): Optional<Transaction>

    @Query("""
        select t from Transaction t where t.rentalItem.id = :rentalItemId and 
        ( :startDate <= t.startDate and :endDate >= t.startDate ) or 
        ( :endDate >= t.endDate and :startDate < t.endDate ) or
        ( :startDate >= t.startDate and :endDate <= t.endDate ) or 
        :startDate = t.endDate or :endDate = t.startDate
    """)
    fun findAllByRentalItemAndDateRange(rentalItemId: Long, startDate: LocalDate, endDate: LocalDate): List<Transaction>

    @Query(
        """
            select t 
            from Transaction t
            where t.rentalItem.owner.id = :ownerId 
            and t.currentStatus.status in (:statusFilter)
            and (upper(t.renter.email) like upper(concat('%', :query, '%')) 
            or upper(t.rentalItem.number) like upper(concat('%', :query, '%')) 
            or upper(t.rentalItem.brand) like upper(concat('%', :query, '%')) 
            or upper(t.rentalItem.shortDescription) like upper(concat('%', :query, '%')) 
            or upper(t.rentalItem.longDescription) like upper(concat('%', :query, '%')))
"""
    )
    fun findByLessorIdAndSearch(
        @Param("ownerId") id: Long,
        @Param("query") query: String?,
        @Param("statusFilter") statusFilter: List<TransactionStatusEnum>,
        pageable: Pageable
    ): Page<Transaction>

}