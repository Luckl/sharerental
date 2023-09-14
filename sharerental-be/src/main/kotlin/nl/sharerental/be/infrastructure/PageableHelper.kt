package nl.sharerental.be.infrastructure

import nl.sharerental.be.search.SearchController
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort

object PageableHelper {

    private const val DEFAULT_PAGE_SIZE = 20

    fun pageRequest(page: Int?, size: Int?, sort: List<String>?): PageRequest {
        val sortFields = sort?.map { s ->
            Sort.Order(
                Sort.Direction.fromString(s.split(';')[1]),
                s.split(';')[0]
            )
        }
            .orEmpty()

        val pageRequest = PageRequest.of(page ?: 0, size ?: DEFAULT_PAGE_SIZE, Sort.by(sortFields))
        return pageRequest
    }
}