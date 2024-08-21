package nl.sharerental.be.rentalitem.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.infrastructure.PageableHelper.pageRequest
import nl.sharerental.be.infrastructure.normalizeString
import nl.sharerental.be.lessor.infrastructure.repository.LessorRepository
import nl.sharerental.be.rentalitem.DisplayStatus
import nl.sharerental.be.rentalitem.FuelType
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.rentalitem.RentalItemAuthorization
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.be.user.RenterType
import nl.sharerental.contract.http.RentalItemApi
import nl.sharerental.contract.http.model.GetRentalItemsResult
import nl.sharerental.contract.http.model.PaginationResponse
import nl.sharerental.contract.http.model.RentalItemInput
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException
import nl.sharerental.contract.http.model.DisplayStatus as HttpDisplayStatus
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
        rentalItemInput.price24h ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST)

        val entity = rentalItemAuthorization.authorizeById(id)

        logger.debug("Previous entity {}", entity.toString())

        entity.apply {
            name = rentalItemInput.name
            externalReference = rentalItemInput.externalReference
            shortDescription = rentalItemInput.shortDescription
            longDescription = rentalItemInput.longDescription
            displayStatus = rentalItemInput.displayStatus.toEntity()
            price24h = rentalItemInput.price24h?.toBigDecimal()!!
            price48h = rentalItemInput.price48h?.toBigDecimal()
            price168h = rentalItemInput.price168h?.toBigDecimal()
            amount = rentalItemInput.amount
            automaticallyAcceptTransaction = rentalItemInput.automaticallyAcceptTransaction
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
            rentToRenterType = rentalItemInput.rentToRenterType?.toEntityEnum()
        }
        logger.debug("Updated entity {}", entity.toString())
        logger.debug("Updated rentalItem {}", id)
        return ResponseEntity.ok(entity.toResponse())
    }

    @Transactional
    override fun createRentalItem(rentalItemInput: RentalItemInput?): ResponseEntity<HttpRentalItem> {

        val lessors = lessorRepository.getIdsForUserId(currentUserService.get().id)

        if (lessors.size != 1) {
            logger.warn("User {} has {} lessors, cannot create rentalItem since we don't know for which lessor", currentUserService.get().id, lessors.size)
            throw ResponseStatusException(HttpStatus.NOT_FOUND)
        }

        val lessor = lessorRepository.findById(lessors[0]).orElseThrow()

        val rentalItem = RentalItem(
            name = rentalItemInput!!.name,
            slug = "${lessor.name} ${rentalItemInput.name}".normalizeString(),
            externalReference = rentalItemInput.externalReference,
            shortDescription = rentalItemInput.shortDescription,
            longDescription = rentalItemInput.longDescription,
            price24h = rentalItemInput.price24h?.toBigDecimal()!!,
            price48h = rentalItemInput.price48h?.toBigDecimal(),
            price168h = rentalItemInput.price168h?.toBigDecimal(),
            automaticallyAcceptTransaction = rentalItemInput.automaticallyAcceptTransaction,
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
            rentToRenterType = rentalItemInput.rentToRenterType?.toEntityEnum(),
            amount = rentalItemInput.amount,
            owner = lessor
        )

        val result = rentalItemRepository.save(rentalItem)

        logger.debug("Created rentalItem {}", result.id)
        return ResponseEntity.ok(HttpRentalItem(result.id, result.name))
    }

    override fun getRentalItems(
        page: Int?,
        size: Int?,
        sort: MutableList<String>?,
        filter: String?,
        lessorId: Long?
    ): ResponseEntity<GetRentalItemsResult> {

        val lessor = if (lessorId != null) {
            lessorRepository.getIdsForUserId(currentUserService.get().id).filter { it == lessorId }.also {
                if (it.isEmpty()) {
                    throw RuntimeException("No lessors found for this ID.")
                }
            }.first()
        } else {
            lessorRepository.getIdsForUserId(currentUserService.get().id).also {
                if (it.size != 1) {
                    throw RuntimeException("Multiple or no lessors for user, cannot find rental items.")
                }
            }.first()
        }

        val actualSort = if (sort?.isEmpty() == true) mutableListOf("id;desc") else sort

        val findAll = rentalItemRepository.findByLessorIdAndSearch(lessor, filter, pageRequest(
            page,
            size,
            actualSort))

        val getRentalItemsResult = GetRentalItemsResult(
            findAll.get().map { it.toResponse() }.toList(),
            PaginationResponse(findAll.totalElements, findAll.totalPages, findAll.number)
        )
        return ResponseEntity.ok(getRentalItemsResult)
    }
}

private fun HttpDisplayStatus.toEntity(): DisplayStatus {
    return when (this) {
        HttpDisplayStatus.ACTIVE -> DisplayStatus.ACTIVE
        HttpDisplayStatus.INACTIVE -> DisplayStatus.INACTIVE
    }
}
private fun nl.sharerental.contract.http.model.FuelType.toEntityEnum(): FuelType = FuelType.valueOf(this.value)
private fun nl.sharerental.contract.http.model.RenterType.toEntityEnum(): RenterType = RenterType.valueOf(this.value)

