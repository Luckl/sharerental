package nl.sharerental.be.lessor.infrastructure

import nl.sharerental.be.lessor.LessorEntity
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.PagingAndSortingRepository

interface LessorRepository: CrudRepository<LessorEntity, Long>, PagingAndSortingRepository<LessorEntity, Long> {

}