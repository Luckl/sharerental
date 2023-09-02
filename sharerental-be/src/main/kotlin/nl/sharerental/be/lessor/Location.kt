package nl.sharerental.be.lessor

import jakarta.persistence.*

@Entity
data class Location(
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
    @Column(name = "house_number_addition")
    val houseNumberAddition: String?,
    @Column(name = "postal_code")
    val postalCode: String?,
    val city: String?,
    val country: String?,
    @Column(name = "geo_location")
    val geoLocation: String?
)