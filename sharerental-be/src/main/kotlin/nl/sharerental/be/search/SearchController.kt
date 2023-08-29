package nl.sharerental.be.search

import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.contract.http.SearchApi
import nl.sharerental.contract.http.model.Pageable
import nl.sharerental.contract.http.model.PaginationResponse
import nl.sharerental.contract.http.model.SearchResult
import nl.sharerental.contract.http.model.SearchResultItem
import org.slf4j.LoggerFactory
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.data.domain.Sort.Order
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import java.net.URI


@RestController
class SearchController(val rentalItemRepository: RentalItemRepository) : SearchApi {

    override fun search(
        query: String?,
        pageable: Pageable?
    ): ResponseEntity<SearchResult> {
        logger.info("querying for string $query")

        val sortFields = pageable?.sort?.map { s ->
            Order(Sort.Direction.fromString(s.split(';')[1]),
                s.split(';')[0]) }
            .orEmpty()

        val pageRequest = PageRequest.of(pageable?.page ?: 0, pageable?.pageSize ?: DEFAULT_PAGE_SIZE, Sort.by(sortFields))

        return ResponseEntity.ok(
            rentalItemRepository.findAll(pageRequest)
                .toResponseObject()
        );
    }

    companion object {
        private val logger = LoggerFactory.getLogger(SearchController::class.java)
        private const val DEFAULT_PAGE_SIZE = 20
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
    searchResultItem.pricePerDay = price_24h
    return searchResultItem

}

