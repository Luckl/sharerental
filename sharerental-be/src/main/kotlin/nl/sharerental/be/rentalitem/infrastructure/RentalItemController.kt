package nl.sharerental.be.rentalitem.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.lessor.infrastructure.repository.LessorRepository
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.contract.http.RentalItemApi
import nl.sharerental.contract.http.model.GetRentalItemsResult
import nl.sharerental.contract.http.model.RentalItem as HttpRentalItem
import nl.sharerental.contract.http.model.RentalItemInput
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import java.math.BigDecimal

@RestController
class RentalItemController(
    private val lessorRepository: LessorRepository,
    private val rentalItemRepository: RentalItemRepository,
    private val currentUserService: CurrentUserService
) : RentalItemApi {

    @Transactional
    override fun createRentalItem(rentalItemInput: RentalItemInput?): ResponseEntity<HttpRentalItem> {

        val lessors = lessorRepository.getIdsForUserId(currentUserService.get().id)

        if (lessors.size > 1) {
            throw RuntimeException("Multiple lessors for user, cannot create rental items.")
        }

        val rentalItem = RentalItem(
            name = rentalItemInput!!.name,
            number = rentalItemInput.number,
            shortDescription = rentalItemInput.shortDescription,
            longDescription = rentalItemInput.longDescription,
            price24h = BigDecimal.valueOf(rentalItemInput.price24h),
            price48h = BigDecimal.valueOf(rentalItemInput.price48h),
            price168h = BigDecimal.valueOf(rentalItemInput.price168h),
            deliveryPossible = rentalItemInput.deliveryPossible,
            deliveryPrice = BigDecimal.valueOf(rentalItemInput.deliveryPrice),
            category = rentalItemInput.category,
            reachMeters = rentalItemInput.reachMeters,
            carryingWeightKilograms = rentalItemInput.carryingWeightKilograms,
            maximumWorkHeightMeters = rentalItemInput.maximumWorkHeightMeters,
            intrinsicWeightKilograms = rentalItemInput.intrinsicWeightKilograms,
            materialType = rentalItemInput.materialType,
            brand = rentalItemInput.brand,
            maximumPressureBars = rentalItemInput.maximumPressureBars,
            maximumHorsePower = rentalItemInput.maximumHorsePower,
            requiredPowerVoltageVolt = rentalItemInput.requiredPowerVoltageVolt,
            workWidthMeters = rentalItemInput.workWidthMeters,
            vacuumAttachmentPossible = rentalItemInput.vacuumAttachmentPossible,
            capacityLiters = rentalItemInput.capacityLiters,
            itemHeight = rentalItemInput.itemHeight,
            itemWidth = rentalItemInput.itemWidth,
            itemLength = rentalItemInput.itemLength,
            powerWatt = rentalItemInput.powerWatt,
            maximumSurfaceSquareMeters = rentalItemInput.maximumSurfaceSquareMeters,
            fuelType = null
        )

        val result = rentalItemRepository.save(rentalItem)

        return ResponseEntity.ok(HttpRentalItem(result.id, result.name))
    }

    override fun getRentalItems(
        page: Int?,
        size: Int?,
        sort: MutableList<String>?,
        filter: String?
    ): ResponseEntity<GetRentalItemsResult> {
        return super.getRentalItems(page, size, sort, filter)
    }

}