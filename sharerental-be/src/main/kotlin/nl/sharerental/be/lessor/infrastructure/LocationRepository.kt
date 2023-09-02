package nl.sharerental.be.lessor.infrastructure

import nl.sharerental.be.lessor.Location
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.PagingAndSortingRepository

interface LocationRepository: CrudRepository<Location, Long>, PagingAndSortingRepository<Location, Long> {
}