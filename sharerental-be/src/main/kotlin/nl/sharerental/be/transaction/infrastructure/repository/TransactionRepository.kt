package nl.sharerental.be.transaction.infrastructure.repository

import nl.sharerental.be.transaction.Transaction
import org.springframework.data.repository.CrudRepository
import java.util.*

interface TransactionRepository: CrudRepository<Transaction, Long> {

    fun findByMolliePaymentReference(molliePaymentReference: String?): Optional<Transaction>
}