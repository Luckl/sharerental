package nl.sharerental.be.rentalitem.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.infrastructure.CloudStorageApi
import nl.sharerental.be.infrastructure.exceptions.BadRequest
import nl.sharerental.be.infrastructure.exceptions.TooManyRequests
import nl.sharerental.be.rentalitem.RentalItemAuthorization
import nl.sharerental.be.search.SearchController
import nl.sharerental.contract.http.RentalItemImageApi
import nl.sharerental.contract.http.model.RentalItemImagesResult
import org.slf4j.LoggerFactory
import org.springframework.core.io.Resource
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import java.util.*
import nl.sharerental.contract.http.model.Image as HttpImage

@Controller
class RentalItemImagesController(
    private val rentalItemAuthorization: RentalItemAuthorization,
    private val cloudStorageApi: CloudStorageApi,
    private val imageUploadRateLimiter: ImageUploadRateLimiter
) : RentalItemImageApi {
    private val logger = LoggerFactory.getLogger(SearchController::class.java)

    @Transactional
    override fun getRentalItemImages(id: Long?): ResponseEntity<RentalItemImagesResult> {

        val item = rentalItemAuthorization.authorizeById(id)
        logger.info("Get images called")

        return ResponseEntity.ok(
            RentalItemImagesResult()
                .embedded(item.images.map { HttpImage(it.id, it.imageUrl) })
        )
    }

    @Transactional
    override fun uploadRentalItemImage(id: Long?, fileType: String?, body: Resource?): ResponseEntity<Void> {

        if (!imageUploadRateLimiter.allowed()) {
            throw TooManyRequests()
        }

        val item = rentalItemAuthorization.authorizeById(id)
        body ?: throw BadRequest()
        fileType ?: throw BadRequest()

        val newFileId = "${item.owner.id}-${id}-RAW-${UUID.randomUUID()}"
        logger.info("uploading new image with ID {}", newFileId)

        cloudStorageApi.uploadFile(newFileId, fileType, body)


        return ResponseEntity.ok().build()
    }

}