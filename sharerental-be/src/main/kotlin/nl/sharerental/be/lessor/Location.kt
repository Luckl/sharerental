package nl.sharerental.be.lessor

import jakarta.persistence.*
import nl.sharerental.contract.http.model.Location as HttpLocation

@Entity
class Location(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    @Column(name = "address_line_1")
    val addressLine1: String?,
    @Column(name = "address_line_2")
    val addressLine2: String?,
    @Column(name = "address_line_3")
    val addressLine3: String?,
    val street: String?,
    @Column(name = "house_number")
    val houseNumber: String?,
    @Column(name = "postal_code")
    val postalCode: String?,
    val city: String?,
    val country: String?,
    @Column(name = "geo_location")
    val geoLocation: String?
) {
    fun toResponse(): HttpLocation {
        val httpLocation = HttpLocation()

        httpLocation.addressLine1 = addressLine1
        httpLocation.addressLine2 = addressLine2
        httpLocation.addressLine3 = addressLine3
        httpLocation.street = street
        httpLocation.houseNumber = houseNumber
        httpLocation.postalCode = postalCode
        httpLocation.city = city
        httpLocation.country = country

        return httpLocation
    }
}