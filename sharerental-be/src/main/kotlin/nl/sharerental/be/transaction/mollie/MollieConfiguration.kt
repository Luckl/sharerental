package nl.sharerental.be.transaction.mollie

import be.woutschoovaerts.mollie.Client
import be.woutschoovaerts.mollie.ClientBuilder
import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.PropertyAccessor
import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.aot.hint.annotation.RegisterReflectionForBinding
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration


/**
 * https://github.com/zwaldeck/mollie
 */
@Configuration
@RegisterReflectionForBinding(
    classes = [
        be.woutschoovaerts.mollie.data.common.AddressRequest::class,
        be.woutschoovaerts.mollie.data.common.ApplicationFee::class,
        be.woutschoovaerts.mollie.data.common.Locale::class,
        be.woutschoovaerts.mollie.data.common.Amount::class,
        be.woutschoovaerts.mollie.data.payment.PaymentMethod::class,
        be.woutschoovaerts.mollie.data.payment.SequenceType::class,
        be.woutschoovaerts.mollie.data.payment.PaymentRequest::class,
        be.woutschoovaerts.mollie.data.payment.PaymentResponse::class,
        be.woutschoovaerts.mollie.data.payment.PaymentStatus::class,
    ]
)
class MollieConfiguration(@Value("\${mollie.apiKey}") private val mollieApiKey: String) {

    @Bean
    fun mollieClient(): Client = ClientBuilder().withApiKey(mollieApiKey).build()
}