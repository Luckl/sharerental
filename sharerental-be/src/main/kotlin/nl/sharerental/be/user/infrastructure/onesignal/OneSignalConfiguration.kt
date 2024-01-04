package nl.sharerental.be.user.infrastructure.onesignal

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.codec.json.Jackson2JsonDecoder
import org.springframework.http.codec.json.Jackson2JsonEncoder
import org.springframework.web.reactive.function.client.ExchangeFilterFunction
import org.springframework.web.reactive.function.client.WebClient

@Configuration
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

    @Bean
    fun oneSignalWebClient(): WebClient = WebClient.builder()
        .baseUrl("https://onesignal.com/api/v1/")
        .defaultHeader("Authorization", "Basic $apiKey")
        .codecs {
            it.registerDefaults(false)
            it.customCodecs().register(Jackson2JsonDecoder())
            it.customCodecs().register(Jackson2JsonEncoder())
        }
        .filter(logResponse())
        .build()
}