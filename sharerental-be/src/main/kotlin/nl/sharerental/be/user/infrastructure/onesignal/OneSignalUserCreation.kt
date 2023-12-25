package nl.sharerental.be.user.infrastructure.onesignal

import nl.sharerental.be.user.User
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.WebClient
import java.time.Instant

@Service
class OneSignalUserCreation(
    private val oneSignalWebClient: WebClient,
    @Value("\${one-signal.app-id}") private val appId: String,
    @Value("\${one-signal.templates.welcome-email}") private val welcomeEmailTemplateId: String,
    @Value("\${one-signal.mock}") private val mock: Boolean,
) {
    private val logger: Logger = LoggerFactory.getLogger(OneSignalUserCreation::class.java)

    fun createNewWebUserInOneSignal(user: User, subscribedToNews: Boolean) {
        logger.info("Creating new OneSignal user for user ${user.id}")
        val body = """
                {
                  "properties": {
                    "language": "nl",
                    "timezone_id": "Europe/Amsterdam",
                    "country": "NL",
                    "first_active": ${Instant.now().epochSecond},
                    "last_active": ${Instant.now().epochSecond}
                  },
                  "identity": {
                    "external_id": "${user.id}"
                  },
                  "subscriptions": [
                    {
                      "type": "Email",
                      "token": "${user.email}",
                      "enabled": $subscribedToNews
                    }
                  ]
                }
                """.trimIndent()

        if (mock) {
            logger.info("MOCK WebClient POST request body: $body")
        } else {
            logger.debug("WebClient POST request body: $body")
            oneSignalWebClient.post()
                .uri("apps/$appId/users")
                .header("accept", "application/json")
                .header("content-type", "application/json")
                .bodyValue(body)
                .retrieve()
                .bodyToMono(String::class.java)
                .block()
        }
    }
}