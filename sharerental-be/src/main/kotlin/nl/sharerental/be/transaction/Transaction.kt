package nl.sharerental.be.transaction

import jakarta.persistence.*
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.user.User
import org.springframework.http.HttpStatus
import org.springframework.web.server.ResponseStatusException
import java.math.BigDecimal
import java.math.RoundingMode
import java.time.LocalDate
import java.time.temporal.ChronoUnit

/**
 *
 * private fun DisplayStatus.toHttp(): nl.sharerental.contract.http.model.DisplayStatus {
 *     return when (this) {
 *         DisplayStatus.ACTIVE -> nl.sharerental.contract.http.model.DisplayStatus.ACTIVE
 *         DisplayStatus.INACTIVE -> nl.sharerental.contract.http.model.DisplayStatus.INACTIVE
 *     }
 * }
 */
//private fun TransactionStatus?.toResponse(): TransactionStatus? {
//    return when (this?.status) {
//        // INITIALIZED, PAID, ACCEPTED, COMPLETED, PAID_OUT, CANCELLED
//        TransactionStatusEnum.PAID ->
//    }
//}

@Entity
@Table(name = "transaction")
data class Transaction(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @ManyToOne
    val rentalItem: RentalItem,

    @ManyToOne
    val renter: User,

    // Future performance improvement:  https://stackoverflow.com/questions/34889644/what-are-the-benefits-of-using-postgresql-daterange-type-instead-of-two-date-fie
    val startDate: LocalDate,
    val endDate: LocalDate,
    val price: BigDecimal,
    val amount: Int = 1,
    var molliePaymentReference: String = "unknown",

    @OneToOne(cascade = [CascadeType.PERSIST])
    var currentStatus: TransactionStatus? = null,
    @OneToMany(mappedBy = "transaction")
    val statusHistory: List<TransactionStatus> = emptyList()
) {

    fun Transaction.toResponse(): nl.sharerental.contract.http.model.Transaction {
        val transaction = this
        return nl.sharerental.contract.http.model.Transaction().apply {
            id = transaction.id
            rentalItem = transaction.rentalItem.toResponse()
            startDate = transaction.startDate
            endDate = transaction.endDate
            amount = transaction.amount
            price = transaction.price
        }
    }

    init {
        if (amount < 1) {
            throw ResponseStatusException(HttpStatus.BAD_REQUEST)
        }
    }

    companion object {
        fun calculatePrice(
            rentalItem: RentalItem,
            startDate: LocalDate,
            endDate: LocalDate,
            amount: Int
        ): BigDecimal {
            return rentalItem.price24h.times(BigDecimal.valueOf(ChronoUnit.DAYS.between(startDate, endDate)))
                .setScale(2, RoundingMode.HALF_UP).times(BigDecimal(amount))
        }
    }


    fun toResponse() =
        nl.sharerental.contract.http.model.Transaction(
            this.id,
            this.startDate,
            this.endDate,
            this.amount,
            this.price,
            this.currentStatus?.toResponse(),
            this.rentalItem.toResponse()
        )

}