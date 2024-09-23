package nl.sharerental.be.location

import jakarta.persistence.Embeddable
import jakarta.persistence.EmbeddedId
import jakarta.persistence.Entity
import jakarta.persistence.Table
import java.io.Serializable
import java.time.LocalDateTime

@Entity
@Table(name = "postal_code_location")
data class PostalCodeLocation(
    @EmbeddedId
    val id: PostalCodeId,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val latitude: Double,
    val longitude: Double,
)

@Embeddable
data class PostalCodeId(
    val postalCode: String,
    val houseNumber: String,
): Serializable