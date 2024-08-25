package nl.sharerental.be.transaction

import jakarta.persistence.*
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.user.Renter
import org.springframework.http.HttpStatus
import org.springframework.web.server.ResponseStatusException
import java.math.BigDecimal
import java.math.RoundingMode
import java.time.LocalDate
import java.time.temporal.ChronoUnit
import kotlin.math.max

@Entity
@Table(name = "transaction")
data class Transaction(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @ManyToOne
    val rentalItem: RentalItem,

    @ManyToOne(cascade = [CascadeType.PERSIST])
    val renter: Renter,

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

    init {
        if (amount < 1) {
            throw ResponseStatusException(HttpStatus.BAD_REQUEST)
        }
    }

    //TODO: Return object that contains calculation subresults such as subtotal ex and incl vat, deposit, amount of days, etc. to prevent recalculation in the frontend.
    companion object {
        fun calculatePrice(
            rentalItem: RentalItem,
            startDate: LocalDate,
            endDate: LocalDate,
            amount: Int,
            includeVat: Boolean
        ): BigDecimal {
            val daysBetween = ChronoUnit.DAYS.between(startDate, endDate)
            val weekPrice = rentalItem.price168h ?: rentalItem.price24h.times(BigDecimal(7))
            val days = max(daysBetween, 1)
            val remainderDays = days % 7
            val weeks = days / 7

            val weekPriceTotal = weekPrice.times(BigDecimal.valueOf(weeks))
            val dayPriceTotal = if (rentalItem.price24h.times(BigDecimal.valueOf(remainderDays)) > weekPrice)
                weekPrice
            else
                rentalItem.price24h.times(BigDecimal.valueOf(remainderDays))

            return dayPriceTotal.plus(weekPriceTotal)
                .times(if (includeVat) BigDecimal(1.21) else BigDecimal(1))
                .plus(rentalItem.deposit)
                .times(BigDecimal(amount))
                .setScale(2, RoundingMode.HALF_UP)

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