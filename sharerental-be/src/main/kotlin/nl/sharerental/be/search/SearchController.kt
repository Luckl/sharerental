package nl.sharerental.be.search

import nl.sharerental.be.rentalitem.repository.RentalItemRepository
import nl.sharerental.contract.http.SearchApi
import nl.sharerental.contract.http.model.PaginationResponse
import nl.sharerental.contract.http.model.SearchResult
import nl.sharerental.contract.http.model.SearchResultItem
import org.slf4j.LoggerFactory
import org.springframework.data.domain.Pageable
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import java.util.*

@RestController
class SearchController(rentalItemRepository: RentalItemRepository): SearchApi {
    override fun searchGet(query: String?, pageable: Pageable?): ResponseEntity<SearchResult> {
        val result = SearchResultItem(1235895, "Bouwdroger 1600W")
        logger.info("querying for string $query")
        result.subtitle = query
        return ResponseEntity.of(
            Optional.of(SearchResult(
            listOf(result),
            PaginationResponse(1, 1, 0))
        ))
    }

    companion object {
        private val logger
                = LoggerFactory.getLogger(SearchController::class.java)
    }
}