package nl.sharerental.be.location

import jakarta.persistence.*
import java.io.Serializable
import java.time.LocalDateTime

@Entity
@Table(name = "postal_code_lat_long")
data class PostalCodeLatLong(
    @EmbeddedId
    val id: PostalCodeLatLongId,
    @Column(insertable=false, updatable=false)
    val postalCode: String,
    @Column(insertable=false, updatable=false)
    val cityName: String,
    @Column(insertable=false, updatable=false)
    val countryCode: String,
    val latitude: Double,
    val longitude: Double,
    val provinceName: String?,
)

@Embeddable
data class PostalCodeLatLongId(
    val postalCode: String,
    val cityName: String,
    val countryCode: String,
): Serializable

