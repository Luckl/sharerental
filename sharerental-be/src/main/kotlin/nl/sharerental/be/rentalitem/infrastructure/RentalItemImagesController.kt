package nl.sharerental.be.rentalitem.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.images.Image
import nl.sharerental.be.images.ImageService
import nl.sharerental.be.infrastructure.CloudStorageApi
import nl.sharerental.be.rentalitem.RentalItemAuthorization
import nl.sharerental.be.search.SearchController
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.contract.http.RentalItemImageApi
import nl.sharerental.contract.http.model.RentalItemImagesResult
import org.slf4j.LoggerFactory
import org.springframework.core.io.Resource
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.web.server.ResponseStatusException
import java.util.*
import nl.sharerental.contract.http.model.Image as HttpImage

@Controller
class RentalItemImagesController(
    private val rentalItemAuthorization: RentalItemAuthorization,
    private val imageUploadRateLimiter: ImageUploadRateLimiter,
    private val imageService: ImageService,
    private val currentUserService: CurrentUserService
) : RentalItemImageApi {
    private val logger = LoggerFactory.getLogger(SearchController::class.java)

    @Transactional
    override fun getRentalItemImages(id: Long?): ResponseEntity<RentalItemImagesResult> {

        val item = rentalItemAuthorization.authorizeById(id)

        return ResponseEntity.ok(
            RentalItemImagesResult()
                .embedded(item.images.map { HttpImage(it.id, it.imageUrl) })
        )
    }

    @Transactional
    override fun uploadRentalItemImage(id: Long?, fileType: String?, body: Resource?): ResponseEntity<Void> {

        if (!imageUploadRateLimiter.allowed()) {
            logger.info("Rate limiting hit by {}", currentUserService.get().id)
            throw ResponseStatusException(HttpStatus.TOO_MANY_REQUESTS)
        }

        val item = rentalItemAuthorization.authorizeById(id)
        body ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST)
        fileType ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST)

        val image: Image = imageService.createImage(item, fileType, body)

        item.images.add(image)

        return ResponseEntity.ok().build()
    }

}