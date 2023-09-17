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
import org.springframework.web.multipart.MultipartFile
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
    override fun uploadRentalItemImage(id: Long?, files: MutableList<MultipartFile>?): ResponseEntity<Void> {
        files ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST)

        if (!imageUploadRateLimiter.allowed(files.size)) {
            logger.error("Rate limiting hit by {}", currentUserService.get().id)
            throw ResponseStatusException(HttpStatus.TOO_MANY_REQUESTS)
        }

        val item = rentalItemAuthorization.authorizeById(id)

        for (file in files) {
            file.contentType ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST)
            val image = imageService.createImage(item, file.contentType!!, file.resource)
            item.images.add(image)
        }

        return ResponseEntity.ok().build()
    }

}