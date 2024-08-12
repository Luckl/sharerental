package nl.sharerental.be.search.infrastructure

import nl.sharerental.be.search.SearchRequestQuery
import org.springframework.data.repository.CrudRepository

interface SearchRequestQueryRepository: CrudRepository<SearchRequestQuery, Long> {

}