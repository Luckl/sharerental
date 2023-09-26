package nl.sharerental.be.transaction

import jakarta.persistence.*
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

)