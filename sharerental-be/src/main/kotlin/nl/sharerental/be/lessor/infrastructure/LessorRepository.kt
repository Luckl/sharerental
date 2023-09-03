package nl.sharerental.be.lessor.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.lessor.LessorEntity
import nl.sharerental.be.user.User
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

@Transactional
interface LessorRepository: CrudRepository<LessorEntity, Long>, PagingAndSortingRepository<LessorEntity, Long> {

    fun findAllByUsersContaining(user: User, pageable: Pageable): Page<LessorEntity>
}