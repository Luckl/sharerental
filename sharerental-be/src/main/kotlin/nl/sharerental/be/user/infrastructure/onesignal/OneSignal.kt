package nl.sharerental.be.user.infrastructure.onesignal

import nl.sharerental.be.user.User
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.ExchangeFilterFunction
import org.springframework.web.reactive.function.client.WebClient
import java.time.Instant

@Service
class OneSignal(
    @Value("\${oneSignal.appId}") private val appId: String,
    @Value("\${oneSignal.apiKey}") private val apiKey: String,
    @Value("\${oneSignal.templates.welcome-email}") private val welcomeEmailTemplateId: String,
) {
    private val logger: Logger = LoggerFactory.getLogger(OneSignal::class.java)

    private val webClient: WebClient = WebClient.builder()
        .baseUrl("https://onesignal.com/api/v1/")
        .defaultHeader("Authorization", "Basic $apiKey")
        .filter(logResponse())
        .build()

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

        logger.info("Body: $body")
        webClient.post()
            .uri("apps/$appId/users")
            .header("accept", "application/json")
            .header("content-type", "application/json")
            .bodyValue(body)
            .retrieve()
            .bodyToMono(String::class.java)
            .block()

    }

    fun sendWelcomeEmail(user: User) {
        logger.info("Sending welcome email to user ${user.id}")
        webClient.post()
            .uri("notifications")
            .header("accept", "application/json")
            .header("content-type", "application/json")
            .bodyValue(
                """
                {
                  "include_email_tokens": [
                    "${user.email}"
                  ],
                  "app_id": "$appId",
                  "template_id": "$welcomeEmailTemplateId"
                }
                """.trimIndent()
            )
            .retrieve()
            .bodyToMono(String::class.java)
            .block()
    }

    private final fun logResponse(): ExchangeFilterFunction = ExchangeFilterFunction.ofResponseProcessor { clientResponse ->
            logger.info("Response status code: ${clientResponse.statusCode()}")
            clientResponse.bodyToMono(String::class.java)
                .map { body ->
                    logger.info("Response body: $body")
                    clientResponse
                }
    }
}