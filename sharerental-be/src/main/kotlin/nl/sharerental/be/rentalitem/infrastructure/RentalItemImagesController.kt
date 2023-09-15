package nl.sharerental.be.rentalitem.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.rentalitem.RentalItemAuthorization
import nl.sharerental.be.search.SearchController
import nl.sharerental.contract.http.RentalItemImageApi
import nl.sharerental.contract.http.model.Image as HttpImage
import nl.sharerental.contract.http.model.RentalItemImagesResult
import org.slf4j.LoggerFactory
import org.springframework.core.io.Resource
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller

@Controller
class RentalItemImagesController(
    private val rentalItemAuthorization: RentalItemAuthorization
) : RentalItemImageApi {
    private val logger = LoggerFactory.getLogger(SearchController::class.java)

    @Transactional
    override fun getRentalItemImages(id: Long?): ResponseEntity<RentalItemImagesResult> {

        val item = rentalItemAuthorization.authorizeById(id)
        logger.info("Get images called")

        item.images.map { HttpImage(it.id, it.imageUrl) }

        return ResponseEntity.ok(
            RentalItemImagesResult()
                .embedded(item.images.map { HttpImage(it.id, it.imageUrl) })
        )
    }

    @Transactional
    override fun uploadRentalItemImage(id: Long?, body: Resource?): ResponseEntity<Void> {
        val item = rentalItemAuthorization.authorizeById(id)

        logger.info("upload image called with {}, {}", body?.filename, body)

        return ResponseEntity.ok().build()
    }
}