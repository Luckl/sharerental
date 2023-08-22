package nl.sharerental.be.rentalitem

import jakarta.persistence.*
import nl.sharerental.be.images.Image
import java.math.BigDecimal
import java.net.URI

@Entity
@Table(name = "rental_item")
data class RentalItem(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(nullable = false)
    val name: String,

    @OneToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "rental_item_images",
        joinColumns = [JoinColumn(name = "rental_item_id")],
        inverseJoinColumns = [JoinColumn(name = "image_id")]
    )
    val images: List<Image> = mutableListOf(),

    val number: String?,
    val shortDescription: String?,
    val longDescription: String?,

    val price_24h: BigDecimal?,
    val price_48h: BigDecimal?,
    val price_168h: BigDecimal?,

    val deliveryPossible: Boolean?,
    val deliveryPrice: BigDecimal?,
    val category: String?,

    val reachMeters: Double?,
    val carryingWeightKilograms: Double?,
    val maximumWorkHeightMeters: Double?,
    val intrinsicWeightKilograms: Double?,

    val materialType: String?,
    val brand: String?,

    val maximumPressureBars: Double?,
    val maximumHorsePower: Double?,
    val requiredPowerVoltageVolt: Double?,
    val workWidthMeters: Double?,

    val vacuumAttachmentPossible: Boolean?,
    val capacityLiters: Double?,
    val itemHeight: Double?,
    val itemWidth: Double?,
    val itemLength: Double?,

    val powerWatt: Double?,
    val maximumSurfaceSquareMeters: Double?,

    @Enumerated(EnumType.STRING)
    val fuelType: FuelType?
)

enum class FuelType {
    GASOLINE,
    PETROL,
    ELECTRIC
}