package nl.sharerental.be.rentalitem.infrastructure.repository

import nl.sharerental.be.rentalitem.RentalItem
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface RentalItemRepository: PagingAndSortingRepository<RentalItem, Long>, CrudRepository<RentalItem, Long> {

    @Query(
        """
            select r 
            from RentalItem r
            where r.owner.id = :ownerId 
            and (upper(r.name) like upper(concat('%', :query, '%')) 
            or upper(r.number) like upper(concat('%', :query, '%')) 
            or upper(r.brand) like upper(concat('%', :query, '%')) 
            or upper(r.shortDescription) like upper(concat('%', :query, '%')) 
            or upper(r.longDescription) like upper(concat('%', :query, '%')))
"""
    )
    fun findByLessorIdAndSearch(
        @Param("ownerId") id: Long,
        @Param("query") query: String?,
        pageable: Pageable
    ): Page<RentalItem>

    @Query(
        """
            select r 
            from RentalItem r
            where r.displayStatus = 'ACTIVE'
            and (upper(r.name) like upper(concat('%', :filter, '%')) 
            or upper(r.brand) like upper(concat('%', :filter, '%')) 
            or upper(r.shortDescription) like upper(concat('%', :filter, '%')) 
            or upper(r.longDescription) like upper(concat('%', :filter, '%')))
"""
    )
    fun search(@Param("filter") filter: String?, pageRequest: PageRequest): Page<RentalItem>


}
