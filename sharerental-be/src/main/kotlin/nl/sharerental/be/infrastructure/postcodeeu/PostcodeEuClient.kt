package nl.sharerental.be.infrastructure.postcodeeu

import org.springframework.beans.factory.annotation.Value
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.WebClient
import org.springframework.web.server.ResponseStatusException

@Service
class PostcodeEuClient(
    @Value("\${share-rental.postcode-eu.key}") private val key: String,
    @Value("\${share-rental.postcode-eu.secret}") private val secret: String,
    @Value("\${share-rental.postcode-eu.dutch-zip-lookup-url}") private val zipLookupUrl: String,
    ) {

    val postcodeEuClient = WebClient.builder()
        .baseUrl(zipLookupUrl)
        .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
        .build()

    fun getZipInfo(zip: String, houseNumber: String): ZipInfo {
        return postcodeEuClient.get()
            .uri("/$zip/$houseNumber")
            .headers {
                it.setBasicAuth(key, secret)
            }
            .retrieve()
            .bodyToMono(ZipInfo::class.java)
            .block() ?: throw ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "No response from postcode.eu")
    }
}

data class ZipInfo(
    val street: String,
    val streetNen: String,
    val houseNumber: Int,
    val houseNumberAddition: String,
    val postcode: String,
    val city: String,
    val cityShort: String,
    val cityId: String,
    val municipality: String,
    val municipalityShort: String,
    val municipalityId: String,
    val province: String,
    val rdX: Int,
    val rdY: Int,
    val latitude: Double,
    val longitude: Double,
    val bagNumberDesignationId: String,
    val bagAddressableObjectId: String,
    val addressType: String,
    val purposes: List<String>,
    val surfaceArea: Int,
    val houseNumberAdditions: List<String>
)