package nl.sharerental.be.rentalitem.repository

import nl.sharerental.be.rentalitem.RentalItem
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.PagingAndSortingRepository

interface RentalItemRepository: PagingAndSortingRepository<RentalItem, Long>, CrudRepository<RentalItem, Long> {

}
