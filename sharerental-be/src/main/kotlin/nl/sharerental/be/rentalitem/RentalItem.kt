package nl.sharerental.be.rentalitem

import jakarta.persistence.*
import nl.sharerental.be.images.Image
import nl.sharerental.be.lessor.Lessor
import org.hibernate.annotations.Type
import java.math.BigDecimal
import java.net.URI

@Entity
@Table(name = "rental_item")
data class RentalItem(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(nullable = false)
    var name: String,

    @OneToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "rental_item_image",
        joinColumns = [JoinColumn(name = "rental_item_id")],
        inverseJoinColumns = [JoinColumn(name = "image_id")]
    )
    var images: List<Image> = mutableListOf(),

    var number: String?,
    var shortDescription: String?,
    var longDescription: String?,

    @ManyToOne
    var owner: Lessor,

    @Column(name = "price_24h")
    var price24h: BigDecimal?,
    @Column(name = "price_48h")
    var price48h: BigDecimal?,
    @Column(name = "price_168h")
    var price168h: BigDecimal?,

    var deliveryPossible: Boolean?,
    var deliveryPrice: BigDecimal?,
    var category: String?,

    var reachMeters: Double?,
    var carryingWeightKilograms: Double?,
    var maximumWorkHeightMeters: Double?,
    var intrinsicWeightKilograms: Double?,

    var materialType: String?,
    var brand: String?,

    var maximumPressureBars: Double?,
    var maximumHorsePower: Double?,
    var requiredPowerVoltageVolt: Double?,
    var workWidthMeters: Double?,

    var vacuumAttachmentPossible: Boolean?,
    var capacityLiters: Double?,
    var itemHeight: Double?,
    var itemWidth: Double?,
    var itemLength: Double?,

    var powerWatt: Double?,
    var maximumSurfaceSquareMeters: Double?,

    @Enumerated(EnumType.STRING)
    var fuelType: FuelType?
)

enum class FuelType {
    GASOLINE,
    PETROL,
    ELECTRIC
}