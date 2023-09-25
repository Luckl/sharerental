package nl.sharerental.be.transaction.mollie

import be.woutschoovaerts.mollie.Client
import be.woutschoovaerts.mollie.ClientBuilder
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration


/**
 * https://github.com/zwaldeck/mollie
 */
@Configuration
class MollieConfiguration(@Value("\${mollie.apiKey}") private val mollieApiKey: String) {

    @Bean
    fun mollieClient(): Client = ClientBuilder().withApiKey(mollieApiKey).build()
}