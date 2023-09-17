package nl.sharerental.be.rentalitem.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.infrastructure.PageableHelper.pageRequest
import nl.sharerental.be.lessor.infrastructure.repository.LessorRepository
import nl.sharerental.be.rentalitem.FuelType
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.rentalitem.RentalItemAuthorization
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.contract.http.RentalItemApi
import nl.sharerental.contract.http.model.GetRentalItemsResult
import nl.sharerental.contract.http.model.PaginationResponse
import nl.sharerental.contract.http.model.RentalItemInput
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException
import nl.sharerental.contract.http.model.FuelType as HttpFuelType
import nl.sharerental.contract.http.model.RentalItem as HttpRentalItem

@RestController
class RentalItemController(
    private val lessorRepository: LessorRepository,
    private val rentalItemRepository: RentalItemRepository,
    private val rentalItemAuthorization: RentalItemAuthorization,
    private val currentUserService: CurrentUserService
) : RentalItemApi {
    private val logger = LoggerFactory.getLogger(RentalItemController::class.java)

    override fun getRentalItem(id: Long?): ResponseEntity<HttpRentalItem> {

        val findById = rentalItemAuthorization.authorizeById(id)

        return ResponseEntity.ok(findById.toResponse())
    }

    @Transactional
    override fun updateRentalItem(
        id: Long?,
        rentalItemInput: RentalItemInput?
    ): ResponseEntity<HttpRentalItem> {
        rentalItemInput ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST)

        val entity = rentalItemAuthorization.authorizeById(id)

        entity.apply {
            name = rentalItemInput.name
            number = rentalItemInput.number
            shortDescription = rentalItemInput.shortDescription
            longDescription = rentalItemInput.longDescription
            price24h = rentalItemInput.price24h?.toBigDecimal()
            price48h = rentalItemInput.price48h?.toBigDecimal()
            price168h = rentalItemInput.price168h?.toBigDecimal()
            deliveryPossible = rentalItemInput.deliveryPossible
            deliveryPrice = rentalItemInput.deliveryPrice?.toBigDecimal()
            category = rentalItemInput.category
            reachMeters = rentalItemInput.reachMeters
            carryingWeightKilograms = rentalItemInput.carryingWeightKilograms
            maximumWorkHeightMeters = rentalItemInput.maximumWorkHeightMeters
            intrinsicWeightKilograms = rentalItemInput.intrinsicWeightKilograms
            materialType = rentalItemInput.materialType
            brand = rentalItemInput.brand
            maximumPressureBars = rentalItemInput.maximumPressureBars
            maximumHorsePower = rentalItemInput.maximumHorsePower
            requiredPowerVoltageVolt = rentalItemInput.requiredPowerVoltageVolt
            workWidthMeters = rentalItemInput.workWidthMeters
            vacuumAttachmentPossible = rentalItemInput.vacuumAttachmentPossible
            capacityLiters = rentalItemInput.capacityLiters
            itemHeight = rentalItemInput.itemHeight
            itemWidth = rentalItemInput.itemWidth
            itemLength = rentalItemInput.itemLength
            powerWatt = rentalItemInput.powerWatt
            maximumSurfaceSquareMeters = rentalItemInput.maximumSurfaceSquareMeters
            fuelType = rentalItemInput.fuelType?.toEntityEnum()
        }

        logger.debug("Updated rentalItem {}", id)
        return ResponseEntity.ok(entity.toResponse())
    }

    @Transactional
    override fun createRentalItem(rentalItemInput: RentalItemInput?): ResponseEntity<HttpRentalItem> {

        val lessors = lessorRepository.getIdsForUserId(currentUserService.get().id)

        if (lessors.size != 1) {
            throw RuntimeException("Multiple or no lessors for user, cannot create rental items.")
        }

        val lessor = lessorRepository.findById(lessors[0]).orElseThrow()

        val rentalItem = RentalItem(
            name = rentalItemInput!!.name,
            number = rentalItemInput.number,
            shortDescription = rentalItemInput.shortDescription,
            longDescription = rentalItemInput.longDescription,
            price24h = rentalItemInput.price24h?.toBigDecimal(),
            price48h = rentalItemInput.price48h?.toBigDecimal(),
            price168h = rentalItemInput.price168h?.toBigDecimal(),
            deliveryPossible = rentalItemInput.deliveryPossible,
            deliveryPrice = rentalItemInput.deliveryPrice?.toBigDecimal(),
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
            fuelType = rentalItemInput.fuelType?.toEntityEnum(),
            owner = lessor
        )

        val result = rentalItemRepository.save(rentalItem)

        logger.debug("Updated rentalItem {}", result.id)
        return ResponseEntity.ok(HttpRentalItem(result.id, result.name))
    }

    override fun getRentalItems(
        page: Int?,
        size: Int?,
        sort: MutableList<String>?,
        filter: String?
    ): ResponseEntity<GetRentalItemsResult> {
        val lessors = lessorRepository.getIdsForUserId(currentUserService.get().id)

        if (lessors.size != 1) {
            throw RuntimeException("Multiple or no lessors for user, cannot find rental items.")
        }

        val findAll = rentalItemRepository.findByLessorIdAndSearch(lessors[0], filter, pageRequest(page, size, sort))

        val getRentalItemsResult = GetRentalItemsResult(
            findAll.get().map { it.toResponse() }.toList(),
            PaginationResponse(findAll.totalElements, findAll.totalPages, findAll.number)
        )
        return ResponseEntity.ok(getRentalItemsResult)
    }

}

private fun RentalItem.toResponse(): HttpRentalItem {
    val item = this;
    return HttpRentalItem()
        .apply {
            id = item.id
            name = item.name
            number = item.number
            shortDescription = item.shortDescription
            longDescription = item.longDescription
            price24h = item.price24h?.toDouble()
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

private fun FuelType.toHttpEnum(): HttpFuelType {
    return HttpFuelType.valueOf(this.name)
}
private fun nl.sharerental.contract.http.model.FuelType.toEntityEnum(): FuelType = FuelType.valueOf(this.value)

