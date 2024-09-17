package nl.sharerental.be.rentalitem.infrastructure

import nl.sharerental.be.blog.infrastructure.repository.BlogArticleRepository
import nl.sharerental.be.rentalitem.DisplayStatus
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import org.slf4j.LoggerFactory
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

//https://nuxtseo.com/sitemap/guides/dynamic-urls
@RestController
class SitemapController(
    private val rentalItemRepository: RentalItemRepository,
    private val blogArticleRepository: BlogArticleRepository
) {
    // logger
    private val logger = LoggerFactory.getLogger(SitemapController::class.java)

    @GetMapping("rentalItemPages")
    fun getRentalItemPages(): List<SitemapPage> {
        return rentalItemRepository
            .findAll()
            .filter { it.displayStatus == DisplayStatus.ACTIVE }
            .map { SitemapPage("/artikelen/${it.slug}") }
    }

    @GetMapping("blogPages")
    fun getBlogPages(): List<SitemapPage> {
        return blogArticleRepository
            .findAll()
            .filter { it.published }
            .filter { !it.deleted }
            .map { SitemapPage("/nieuwsbrief/${it.slug}") }
    }
}

data class SitemapPage(
    val loc: String,
)