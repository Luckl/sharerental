package nl.sharerental.be.contactform

import nl.sharerental.be.contactform.infrastructure.repository.PostalCodeLocationRepository
import nl.sharerental.be.infrastructure.postcodeeu.PostcodeEuClient
import nl.sharerental.contract.http.model.GetAddressByZipcode200Response
import org.springframework.stereotype.Service

@Service
class LocationService(
    private val postcodeEuClient: PostcodeEuClient,
    private val postalCodeLocationRepository: PostalCodeLocationRepository,
) {
    fun getLocation(zip: String, houseNumber: String): GetAddressByZipcode200Response {
        val zipInfo = postcodeEuClient.getZipInfo(zip, houseNumber)

        postalCodeLocationRepository.save(
            PostalCodeLocation(
                id = PostalCodeId(zip, houseNumber),
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
}