package nl.sharerental.be.search

import nl.sharerental.be.infrastructure.PageableHelper.pageRequest
import nl.sharerental.be.jooq.generated.enums.FuelTypeEnum
import nl.sharerental.be.jooq.generated.enums.RentalItemDisplayStatus
import nl.sharerental.be.jooq.generated.tables.RentalItem.RENTAL_ITEM
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.contract.http.SearchApi
import nl.sharerental.contract.http.model.PaginationResponse
import nl.sharerental.contract.http.model.SearchResult
import nl.sharerental.contract.http.model.SearchResultItem
import org.jooq.Condition
import org.jooq.DSLContext
import org.jooq.Record1
import org.jooq.SelectConditionStep
import nl.sharerental.contract.http.model.RentalItem as HttpRentalItem
import org.slf4j.LoggerFactory
import org.springframework.data.domain.Page
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException
import java.net.URI


@RestController
class SearchController(
    private val rentalItemRepository: RentalItemRepository,
    private val create: DSLContext,
    ) : SearchApi {

    override fun search(
        query: String?,
        page: Int?,
        size: Int?,
        sort: MutableList<String>?
    ): ResponseEntity<SearchResult> {
        logger.debug("Search query registered - [$query]")

        val pageRequest = pageRequest(page, size, sort)

        val toResponseObject = rentalItemRepository.search(query, pageRequest)
            .toResponseObject()

        val baseRentalItemQuery = create.selectCount()
            .from(RENTAL_ITEM)
            .where(RENTAL_ITEM.DISPLAY_STATUS.eq(RentalItemDisplayStatus.ACTIVE))
            .and(
                RENTAL_ITEM.NAME.likeIgnoreCase("%$query%")
                    .or(RENTAL_ITEM.BRAND.likeIgnoreCase("%$query%"))
                    .or(RENTAL_ITEM.SHORT_DESCRIPTION.likeIgnoreCase("%$query%"))
                    .or(RENTAL_ITEM.LONG_DESCRIPTION.likeIgnoreCase("%$query%"))
            )

        val count = getCountForEnumFilter(
            RENTAL_ITEM.FUEL_TYPE.`in`(listOf(FuelTypeEnum.PETROL)),
            baseRentalItemQuery
        )

        logger.info("count: {}", count.execute())

        return ResponseEntity.ok(
            toResponseObject
        )
    }

    private fun getCountForEnumFilter(condition: Condition, baseRentalItemQuery: SelectConditionStep<Record1<Int>>) = baseRentalItemQuery
        .and(condition)

    override fun searchCategory(
        category: String?,
        page: Int?,
        size: Int?,
        sort: MutableList<String>?
    ): ResponseEntity<SearchResult> {
        return rentalItemRepository.findByCategory(
            category,
            pageRequest(page, size, sort)
        )
            .toResponseObject()
            .let { ResponseEntity.ok(it) }
    }

    override fun searchDetails(slug: String?): ResponseEntity<HttpRentalItem>? {
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
    searchResultItem.rentalItemSlug = slug
    searchResultItem.subtitle = shortDescription
    searchResultItem.imageUrl = images.map { it.imageUrl }.map { URI(it) }.firstOrNull()
    searchResultItem.pricePerDay = price24h
    searchResultItem.shortDescription = shortDescription
    searchResultItem.lessor = owner.name
    searchResultItem.lessorCity = owner.primaryLocation.city
    return searchResultItem

}
