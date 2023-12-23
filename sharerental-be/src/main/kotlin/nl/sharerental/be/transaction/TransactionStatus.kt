package nl.sharerental.be.transaction

import jakarta.persistence.*
import nl.sharerental.contract.http.model.TransactionStatus
import java.time.Instant

@Entity
@Table(name = "transaction_status")
class TransactionStatus (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    val createdTimestamp: Instant = Instant.now(),

    @Enumerated(EnumType.STRING)
    val status: TransactionStatusEnum = TransactionStatusEnum.INITIALIZED,

    val notes: String? = null,

    @ManyToOne
    val transaction: Transaction
) {
    fun toResponse(): TransactionStatus {
        return when(this.status) {
            TransactionStatusEnum.INITIALIZED -> TransactionStatus.INITIALIZED
            TransactionStatusEnum.PAID -> TransactionStatus.PAID
            TransactionStatusEnum.ACCEPTED -> TransactionStatus.ACCEPTED
            TransactionStatusEnum.COMPLETED -> TransactionStatus.COMPLETED
            TransactionStatusEnum.PAID_OUT -> TransactionStatus.PAID_OUT
            TransactionStatusEnum.CANCELLED -> TransactionStatus.CANCELLED
        }
    }
}