package nl.sharerental.be.rentalitem.infrastructure

import nl.sharerental.be.rentalitem.DisplayStatus
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import org.slf4j.LoggerFactory
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

//https://nuxtseo.com/sitemap/guides/dynamic-urls
@RestController
class RentalItemPagesController(
    private val rentalItemRepository: RentalItemRepository
) {
    // logger
    private val logger = LoggerFactory.getLogger(RentalItemPagesController::class.java)

    @GetMapping("rentalItemPages")
    fun getRentalItemPages(): List<RentalItemPage> {
        logger.info("Returning rental item pages")
        return rentalItemRepository
            .findAll()
            .filter { it.displayStatus == DisplayStatus.ACTIVE }
            .map { RentalItemPage("/artikelen/${it.slug}") }
    }
}

data class RentalItemPage(
    val loc: String,
)