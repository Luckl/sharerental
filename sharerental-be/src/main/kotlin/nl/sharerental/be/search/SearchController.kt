package nl.sharerental.be.search

import nl.sharerental.be.infrastructure.PageableHelper.pageRequest
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.contract.http.SearchApi
import nl.sharerental.contract.http.model.PaginationResponse
import nl.sharerental.contract.http.model.RentalItem1
import nl.sharerental.contract.http.model.SearchResult
import nl.sharerental.contract.http.model.SearchResultItem
import org.slf4j.LoggerFactory
import org.springframework.data.domain.Page
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException
import java.net.URI


@RestController
class SearchController(val rentalItemRepository: RentalItemRepository) : SearchApi {

    override fun search(
        query: String?,
        page: Int?,
        size: Int?,
        sort: MutableList<String>?
    ): ResponseEntity<SearchResult> {
        logger.debug("querying for string $query")

        val pageRequest = pageRequest(page, size, sort)

        return ResponseEntity.ok(
            rentalItemRepository.search(query, pageRequest)
                .toResponseObject()
        )
    }

    override fun searchDetails(slug: String?): ResponseEntity<RentalItem1> {
        slug ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST)

        return rentalItemRepository.findBySlugAndDisplayStatus(slug)
            .map { it.toResponse() }
            .map { ResponseEntity.ok(it) }
            .orElse(ResponseEntity.notFound().build())
    }

    companion object {
        private val logger = LoggerFactory.getLogger(SearchController::class.java)
    }
}

private fun Page<RentalItem>.toResponseObject(): SearchResult {
    val toList = this.get()
        .map { it.toSearchResultItem() }
        .toList()

    return SearchResult(toList, PaginationResponse(this.totalElements, this.totalPages, this.number))
}

private fun RentalItem.toSearchResultItem(): SearchResultItem {
    val searchResultItem = SearchResultItem(id, name)
    searchResultItem.subtitle = shortDescription
    searchResultItem.imageUrl = images.map { it.imageUrl }.map { URI(it) }.firstOrNull()
    searchResultItem.pricePerDay = price24h
    searchResultItem.shortDescription = shortDescription
    searchResultItem.lessor = owner.name
    searchResultItem.lessorCity = owner.primaryLocation.city
    return searchResultItem

}


private fun RentalItem.toResponse(): RentalItem1 {
    val item = this;
    return RentalItem1()
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
        }

}