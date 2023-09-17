package nl.sharerental.be.images.infrastructure

import com.google.cloud.storage.BlobId
import com.google.cloud.storage.BlobInfo
import com.google.cloud.storage.Storage
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.core.io.Resource
import org.springframework.stereotype.Component


@Component
class CloudStorageApi(
    @Value("\${gcp.bucket.public.name}") private val bucketName: String,
    private val storage: Storage
) {
    private val logger = LoggerFactory.getLogger(CloudStorageApi::class.java)

    fun uploadFile(fileId: String, fileType: String, blob: Resource): StorageInfo {

        val blobId = BlobId.of(bucketName, fileId)
        val build = BlobInfo.newBuilder(blobId).setContentType(fileType).build()

        val create = storage.create(build, blob.contentAsByteArray)

        val mediaLink = "https://storage.googleapis.com/$bucketName/${create.asBlobInfo().name}"
        logger.debug("created new public file {}", mediaLink)
        return StorageInfo(mediaLink, create.generatedId)
    }

    fun removeFile(fileId: String) {
        storage.delete(BlobId.of(bucketName, fileId))
    }
}

data class StorageInfo(
    val mediaLink: String,
    val mediaId: String
)