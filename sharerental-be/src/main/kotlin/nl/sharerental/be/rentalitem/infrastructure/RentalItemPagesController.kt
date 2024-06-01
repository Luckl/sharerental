package nl.sharerental.be.rentalitem.infrastructure

import nl.sharerental.be.rentalitem.DisplayStatus
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

//https://nuxtseo.com/sitemap/guides/dynamic-urls
@RestController
class RentalItemPagesController(
    private val rentalItemRepository: RentalItemRepository
) {

    @GetMapping("rentalItemPages")
    fun getRentalItemPages(): List<RentalItemPage> {
        return rentalItemRepository
            .findAll()
            .filter { it.displayStatus == DisplayStatus.ACTIVE }
            .map { RentalItemPage("/artikelen/${it.slug}") }
    }
}

data class RentalItemPage(
    val loc: String,
    val __sitemap: String = "rental-items"
)