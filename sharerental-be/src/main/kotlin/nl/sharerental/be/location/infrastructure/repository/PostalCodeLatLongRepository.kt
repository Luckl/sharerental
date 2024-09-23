package nl.sharerental.be.location.infrastructure.repository

import nl.sharerental.be.location.PostalCodeLatLong
import nl.sharerental.be.location.PostalCodeLatLongId
import org.springframework.data.jpa.repository.JpaRepository

interface PostalCodeLatLongRepository: JpaRepository<PostalCodeLatLong, PostalCodeLatLongId> {
    fun findByPostalCodeAndCountryCode(postalCode: String, countryCode: String): PostalCodeLatLong?
}