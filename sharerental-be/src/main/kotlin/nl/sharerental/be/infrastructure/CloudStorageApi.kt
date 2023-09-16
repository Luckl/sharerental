package nl.sharerental.be.infrastructure

import com.google.cloud.storage.BlobId
import com.google.cloud.storage.BlobInfo
import com.google.cloud.storage.Storage
import nl.sharerental.be.search.SearchController
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.core.io.Resource
import org.springframework.stereotype.Component
import org.springframework.util.StreamUtils
import java.nio.charset.Charset


@Component
class CloudStorageApi(
    @Value("\${gcp.bucket.public.name}") private val bucketName: String,
    private val storage: Storage
) {
    private val logger = LoggerFactory.getLogger(CloudStorageApi::class.java)

    fun uploadFile(fileId: String, fileType: String, blob: Resource): String {

        val blobId = BlobId.of(bucketName, fileId)
        val build = BlobInfo.newBuilder(blobId).setContentType(fileType).build()

        val create = storage.create(build, blob.contentAsByteArray)

        val mediaLink = "https://$bucketName/storage.googleapis.com/${create.asBlobInfo().name}"
        logger.info("created new public file {}", mediaLink)
        return mediaLink
    }
}