package nl.sharerental.be.transaction.infrastructure.repository

import nl.sharerental.be.transaction.Transaction
import org.springframework.data.repository.CrudRepository

interface TransactionRepository: CrudRepository<Transaction, Long> {

}