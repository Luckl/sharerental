package nl.sharerental.be.infrastructure.slack

import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.http.HttpHeaders.CONTENT_TYPE
import org.springframework.http.MediaType.APPLICATION_JSON_VALUE
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.WebClient

@Service
class SlackClient(
    @Value("\${share-rental.slack.platform-events-url}") private val platformEventsUrl: String,
) {

    private val logger = LoggerFactory.getLogger(SlackClient::class.java)

    val slackClient = WebClient.builder()
        .baseUrl(platformEventsUrl)
        .defaultHeader(CONTENT_TYPE, APPLICATION_JSON_VALUE)
        .build()

    fun sendSlackMessage(message: String) {
        try {
            slackClient.post()
                .bodyValue(mapOf("text" to message))
                .retrieve()
                .bodyToMono(String::class.java)
                .block()
        } catch (e: Exception) {
            logger.error("Failed to send slack message", e)
        }
    }
}