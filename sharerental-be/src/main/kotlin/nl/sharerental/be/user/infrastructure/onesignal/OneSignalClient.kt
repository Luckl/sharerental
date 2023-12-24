package nl.sharerental.be.user.infrastructure.onesignal

import nl.sharerental.be.user.User
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.ExchangeFilterFunction
import org.springframework.web.reactive.function.client.WebClient
import java.time.Instant

@Service
class OneSignalClient(
    @Value("\${one-signal.app-id}") private val appId: String,
    @Value("\${one-signal.api-key}") private val apiKey: String,
    @Value("\${one-signal.templates.welcome-email}") private val welcomeEmailTemplateId: String,
    @Value("\${one-signal.mock}") private val mock: Boolean,
) : OneSignal {
    private val logger: Logger = LoggerFactory.getLogger(OneSignalClient::class.java)

    private val webClient: WebClient = WebClient.builder()
        .baseUrl("https://onesignal.com/api/v1/")
        .defaultHeader("Authorization", "Basic $apiKey")
        .filter(logResponse())
        .build()

    override fun createNewWebUserInOneSignal(user: User, subscribedToNews: Boolean) {
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
            webClient.post()
                .uri("apps/$appId/users")
                .header("accept", "application/json")
                .header("content-type", "application/json")
                .bodyValue(body)
                .retrieve()
                .bodyToMono(String::class.java)
                .block()
        }
    }

    override fun sendWelcomeEmail(user: User) {
        logger.info("Sending welcome email to user ${user.id}")
        val body = """
                {
                  "include_email_tokens": [
                    "${user.email}"
                  ],
                  "app_id": "$appId",
                  "template_id": "$welcomeEmailTemplateId",
                  "include_unsubscribed": true,
                  "custom_data": {
                    "username": "${user.username}"
                  }
                }
                """.trimIndent()

        if (mock) {
            logger.info("MOCK WebClient POST request body: $body")
        } else {
            logger.debug("WebClient POST request body: $body")
            webClient.post()
                .uri("notifications")
                .header("accept", "application/json")
                .header("content-type", "application/json")
                .bodyValue(body)
                .retrieve()
                .bodyToMono(String::class.java)
                .block()
        }
    }

    private final fun logResponse(): ExchangeFilterFunction =
        ExchangeFilterFunction.ofResponseProcessor { clientResponse ->
            logger.debug("Response status code: {}", clientResponse.statusCode())
            clientResponse.bodyToMono(String::class.java)
                .map { body ->
                    logger.debug("Response body: $body")
                    clientResponse
                }
        }
}