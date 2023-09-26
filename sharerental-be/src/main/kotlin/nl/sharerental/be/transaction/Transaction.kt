package nl.sharerental.be.transaction

import jakarta.persistence.*
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.user.User
import java.math.BigDecimal
import java.time.LocalDate
import java.time.temporal.ChronoUnit

@Entity
@Table(name = "transaction")
data class Transaction (
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
    var molliePaymentReference: String = "unknown",

    @OneToOne(cascade = [CascadeType.PERSIST])
    var currentStatus: TransactionStatus? = null,
    @OneToMany(mappedBy="transaction")
    val statusHistory: List<TransactionStatus> = emptyList()
) {
    companion object {
        fun calculatePrice(rentalItem: RentalItem, startDate: LocalDate, endDate: LocalDate): BigDecimal {
            return rentalItem.price24h.times(BigDecimal.valueOf(ChronoUnit.DAYS.between(startDate, endDate)))
        }
    }
}