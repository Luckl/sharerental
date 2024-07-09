package nl.sharerental.be.infrastructure.ipapi

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.WebClient

/**
 * https://ip-api.com/docs/api:json
 */
@Service
class IpApiClient(
    @Value("\${share-rental.ip-api.base-url}") private val ipApiBaseUrl: String,
) {
    private val logger: Logger = LoggerFactory.getLogger(IpApiClient::class.java)

    val ipApi = WebClient.builder()
        .baseUrl(ipApiBaseUrl)
        .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
        .build()

    fun getIp(ip: String): IpInfo? {
        val result = ipApi.get()
            .uri(ip)
            .retrieve()
            .bodyToMono(IpInfo::class.java)
            .block()

        logger.debug("Ip info: $result")

        return result
    }

}

data class IpInfo(
    val query: String,
    val status: String,
    val countryCode: String,
    val country: String,
    val region: String,
    val regionName: String,
    val city: String,
    val zip: String,
    val lat: Double,
    val lon: Double,
    val timezone: String,
    val isp: String,
    val org: String,
)