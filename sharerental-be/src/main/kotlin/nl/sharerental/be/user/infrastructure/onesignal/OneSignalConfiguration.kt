package nl.sharerental.be.user.infrastructure.onesignal

import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule
import com.fasterxml.jackson.module.kotlin.KotlinModule
import nl.sharerental.be.infrastructure.postcodeeu.ZipInfo
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.aot.hint.annotation.RegisterReflectionForBinding
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.reactive.function.client.ExchangeFilterFunction
import org.springframework.web.reactive.function.client.WebClient

@Configuration
@RegisterReflectionForBinding(
    classes = [
        OneSignalEmailRequest::class,
        WelcomeEmailCustomData::class,
        ItemRentedLessorEmailCustomData::class,
        ZipInfo::class,
    ]
)
class OneSignalConfiguration(
    @Value("\${one-signal.api-key}") private val apiKey: String,
) {
    private val logger: Logger = LoggerFactory.getLogger(OneSignalConfiguration::class.java)

    private final fun logResponse(): ExchangeFilterFunction =
        ExchangeFilterFunction.ofResponseProcessor { clientResponse ->
            logger.debug("Response status code: {}", clientResponse.statusCode())
            clientResponse.bodyToMono(String::class.java)
                .map { body ->
                    logger.debug("Response body: $body")
                    clientResponse
                }
        }

    /**
     * configure objectMapper with kotlin module
     */
    @Bean
    fun objectMapper(): ObjectMapper = ObjectMapper()
        .registerModule(KotlinModule.Builder().build())
        .registerModule(JavaTimeModule())

    @Bean
    fun oneSignalWebClient(): WebClient = WebClient.builder()
        .baseUrl("https://onesignal.com/api/v1/")
        .defaultHeader("Authorization", "Basic $apiKey")
        .filter(logResponse())
        .build()
}