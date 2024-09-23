package nl.sharerental.be.location

import nl.sharerental.be.location.infrastructure.repository.PostalCodeLocationRepository
import nl.sharerental.be.infrastructure.postcodeeu.PostcodeEuClient
import nl.sharerental.be.location.infrastructure.repository.PostalCodeLatLongRepository
import nl.sharerental.contract.http.model.GetAddressByZipcode200Response
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service

@Service
class LocationService(
    private val postcodeEuClient: PostcodeEuClient,
    private val postalCodeLocationRepository: PostalCodeLocationRepository,
    private val postalCodeLatLongRepository: PostalCodeLatLongRepository,
) {
    private val logger = LoggerFactory.getLogger(LocationService::class.java)

    fun getLocation(postalCode: String, houseNumber: String): GetAddressByZipcode200Response {
        val zipInfo = postcodeEuClient.getZipInfo(postalCode, houseNumber)

        postalCodeLocationRepository.save(
            PostalCodeLocation(
                id = PostalCodeId(postalCode, houseNumber),
                latitude = zipInfo.latitude,
                longitude = zipInfo.longitude
            )
        )

        return if (zipInfo.houseNumberAdditions.size > 1) GetAddressByZipcode200Response().apply {
            street = zipInfo.street
            city = zipInfo.city
            province = zipInfo.province
            country = "Nederland"
            additions = zipInfo.houseNumberAdditions
        } else GetAddressByZipcode200Response().apply {
            street = zipInfo.street
            city = zipInfo.city
            province = zipInfo.province
            country = "Nederland"
        }
    }

    fun getLocationByPostalCode(postalCode: String): GeoLocation? {

        val trimmedPostalCode = postalCode.replace("\\s".toRegex(), "")

        if (trimmedPostalCode.matches(Regex("[0-9]{4}[a-zA-Z]{2}"))) {
            val dutchPostalCodeDigits = Regex("\\d{4}").find(trimmedPostalCode)?.value

            if (dutchPostalCodeDigits == null) {
                logger.info("Invalid postal code: $postalCode")
                return null
            }

            return postalCodeLatLongRepository.findByPostalCodeAndCountryCode(dutchPostalCodeDigits, "NL")
                ?.let { GeoLocation(it.latitude, it.longitude)   }
        } else if (postalCode.matches(Regex("[0-9]{4}"))) {
            return postalCodeLatLongRepository.findByPostalCodeAndCountryCode(postalCode, "BE")
                ?.let { GeoLocation(it.latitude, it.longitude)   }
        } else {
            logger.info("Invalid postal code: $postalCode")
            return null
        }
    }
}

data class GeoLocation(
    val latitude: Double,
    val longitude: Double
)