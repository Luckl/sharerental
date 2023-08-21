package nl.sharerental.be.search

import nl.sharerental.be.rentalitem.repository.RentalItemRepository
import nl.sharerental.contract.http.SearchApiController

class SearchController(rentalItemRepository: RentalItemRepository): SearchApiController() {
}