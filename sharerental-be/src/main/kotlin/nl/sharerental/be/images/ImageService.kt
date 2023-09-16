package nl.sharerental.be.images

import nl.sharerental.be.infrastructure.CloudStorageApi
import nl.sharerental.be.rentalitem.RentalItem
import org.slf4j.LoggerFactory
import org.springframework.core.io.Resource
import org.springframework.stereotype.Component
import java.util.*

@Component
class ImageService(private val cloudStorageApi: CloudStorageApi) {

    private val logger = LoggerFactory.getLogger(ImageService::class.java)

    fun createImage(item: RentalItem, fileType: String, body: Resource): Image {
        val newFileId = "${item.owner.id}-${item.id}-RAW-${UUID.randomUUID()}"
        logger.info("uploading new image with ID {}", newFileId)

        val link = cloudStorageApi.uploadFile(newFileId, fileType, body)

        return Image(imageUrl = link)
    }
}