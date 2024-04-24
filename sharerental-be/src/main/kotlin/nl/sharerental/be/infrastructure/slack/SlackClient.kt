package nl.sharerental.be.infrastructure.slack

import org.springframework.beans.factory.annotation.Value
import org.springframework.http.HttpHeaders.CONTENT_TYPE
import org.springframework.http.MediaType.APPLICATION_JSON_VALUE
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.WebClient

@Service
class SlackClient(
    @Value("\${share-rental.slack.platform-events-url}") private val platformEventsUrl: String,
) {

    val slackClient = WebClient.builder()
        .baseUrl(platformEventsUrl)
        .defaultHeader(CONTENT_TYPE, APPLICATION_JSON_VALUE)
        .build()

    fun sendSlackMessage(message: String) {
        slackClient.post()
            .bodyValue(mapOf("text" to message))
            .retrieve()
            .bodyToMono(String::class.java)
            .block()
    }

}