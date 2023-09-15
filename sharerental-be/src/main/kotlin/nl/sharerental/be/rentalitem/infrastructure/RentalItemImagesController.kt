package nl.sharerental.be.rentalitem.infrastructure

import nl.sharerental.be.search.SearchController
import nl.sharerental.contract.http.RentalItemImageApi
import nl.sharerental.contract.http.model.RentalItemImagesResult
import org.slf4j.LoggerFactory
import org.springframework.core.io.Resource
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller

@Controller
class RentalItemImagesController: RentalItemImageApi {
    private val logger = LoggerFactory.getLogger(SearchController::class.java)

    override fun getRentalItemImages(id: Long?): ResponseEntity<RentalItemImagesResult> {
        logger.info("Get images called")
        return super.getRentalItemImages(id)
    }

    override fun uploadRentalItemImage(id: Long?, body: Resource?): ResponseEntity<Void> {
        logger.info("upload image called with {}, {}", body?.filename, body)
        return super.uploadRentalItemImage(id, body)
    }
}