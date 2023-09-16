package nl.sharerental.be.rentalitem.infrastructure

import io.github.bucket4j.Bandwidth
import io.github.bucket4j.Bucket
import io.github.bucket4j.Refill
import org.springframework.stereotype.Component
import java.time.Duration

@Component
class ImageUploadRateLimiter() {

    private final val imageUploadRateLimit: Bucket
    private final val uploadsCount: Long = 5
    private final val uploadsInterval: Duration = Duration.ofMinutes(1)
    init {
        val limit: Bandwidth = Bandwidth.classic(uploadsCount, Refill.intervally(uploadsCount, uploadsInterval))
        this.imageUploadRateLimit = Bucket.builder()
            .addLimit(limit)
            .build()
    }

    fun allowed(): Boolean = imageUploadRateLimit.tryConsume(1)

}