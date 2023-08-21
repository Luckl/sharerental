package nl.sharerental.be.rentalitem

import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import java.math.BigDecimal
import java.net.URI

@Entity
class RentalItem(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    val title: String,
    val number: String? = null,
    val subtitle: String? = null,
    val shortDescription: String? = null,
    val imageUrl: URI? = null,
    val pricePerDay: BigDecimal? = null,
)