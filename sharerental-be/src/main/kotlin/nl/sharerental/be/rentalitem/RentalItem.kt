package nl.sharerental.be.rentalitem

import jakarta.persistence.*
import nl.sharerental.be.images.Image
import nl.sharerental.contract.http.model.Image as HttpImage
import nl.sharerental.be.lessor.Lessor
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
    @Column(nullable = false)
    var slug: String,

    @OneToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "rental_item_image",
        joinColumns = [JoinColumn(name = "rental_item_id")],
        inverseJoinColumns = [JoinColumn(name = "image_id")]
    )
    var images: MutableList<Image> = mutableListOf(),

    var externalReference: String?,
    var shortDescription: String?,
    var longDescription: String?,

    var amount: Int = 1,

    @ManyToOne
    var owner: Lessor,

    @Column(name = "price_24h")
    var price24h: BigDecimal,
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
    var fuelType: FuelType?,

    @Enumerated(EnumType.STRING)
    var displayStatus: DisplayStatus = DisplayStatus.INACTIVE
) {

     fun toResponse(): nl.sharerental.contract.http.model.RentalItem {
        val item = this
         return nl.sharerental.contract.http.model.RentalItem()
            .apply {
                id = item.id
                images = item.images.map { HttpImage(it.id, it.imageUrl) }
                name = item.name
                externalReference = item.externalReference
                displayStatus = item.displayStatus.toHttp()
                shortDescription = item.shortDescription
                longDescription = item.longDescription
                price24h = item.price24h.toDouble()
                price48h = item.price48h?.toDouble()
                price168h = item.price168h?.toDouble()
                deliveryPossible = item.deliveryPossible
                deliveryPrice = item.deliveryPrice?.toDouble()
                category = item.category
                reachMeters = item.reachMeters
                carryingWeightKilograms = item.carryingWeightKilograms
                maximumWorkHeightMeters = item.maximumWorkHeightMeters
                intrinsicWeightKilograms = item.intrinsicWeightKilograms
                materialType = item.materialType
                brand = item.brand
                maximumPressureBars = item.maximumPressureBars
                maximumHorsePower = item.maximumHorsePower
                requiredPowerVoltageVolt = item.requiredPowerVoltageVolt
                workWidthMeters = item.workWidthMeters
                vacuumAttachmentPossible = item.vacuumAttachmentPossible
                capacityLiters = item.capacityLiters
                itemHeight = item.itemHeight
                itemWidth = item.itemWidth
                itemLength = item.itemLength
                powerWatt = item.powerWatt
                maximumSurfaceSquareMeters = item.maximumSurfaceSquareMeters
                fuelType = item.fuelType?.toHttpEnum()
            }

    }
}

private fun DisplayStatus.toHttp(): nl.sharerental.contract.http.model.DisplayStatus {
    return when (this) {
        DisplayStatus.ACTIVE -> nl.sharerental.contract.http.model.DisplayStatus.ACTIVE
        DisplayStatus.INACTIVE -> nl.sharerental.contract.http.model.DisplayStatus.INACTIVE
    }
}
private fun FuelType.toHttpEnum(): nl.sharerental.contract.http.model.FuelType {
    return nl.sharerental.contract.http.model.FuelType.valueOf(this.name)
}
enum class DisplayStatus {
ACTIVE, INACTIVE
}

enum class FuelType {
    GASOLINE,
    PETROL,
    ELECTRIC
}