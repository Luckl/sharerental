package nl.sharerental.be.lessor.infrastructure.repository

import jakarta.transaction.Transactional
import nl.sharerental.be.lessor.Lessor
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

@Transactional
interface LessorRepository: CrudRepository<Lessor, Long>, PagingAndSortingRepository<Lessor, Long> {

    // Can't get this query to work for some reason due to Cannot invoke "org.hibernate.metamodel.mapping.DiscriminatorType.getJdbcJavaType()" because "this.discriminatorType" is null
    // Switching to a native query and a select afterwards
//    @Query("select Lessor from Lessor l join UserLessor ul on ul.lessor.id = l.id where ul.user.id = :userId")
//    fun findAllByUserId(@Param("userId") userId: String, pageable: Pageable): Page<Lessor>

    @Query("""
        select l.id from Lessor l 
        join user_lessor ul on ul.lessor_id = l.id
        where ul.user_id = :userId
    """, nativeQuery = true)
    fun getIdsForUserId(@Param("userId") userId: String): List<Long>

    fun findByIdIn(ids: List<Long>, pageable: Pageable): Page<Lessor>
}