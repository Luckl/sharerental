package nl.sharerental.be.transaction.mollie

import be.woutschoovaerts.mollie.Client
import be.woutschoovaerts.mollie.data.common.Amount
import be.woutschoovaerts.mollie.data.payment.PaymentRequest
import be.woutschoovaerts.mollie.data.payment.PaymentStatus
import com.fasterxml.jackson.databind.ObjectMapper
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import java.math.BigDecimal
import java.util.*

@Service
class TransactionProcessor(
    private val mollieClient: Client,
    @Value("\${shareRental.callbackUrl}")
    private val callbackUrl: String,

    @Value("\${shareRental.webhookUrl}")
    private val webhookUrl: String,

    private val objectMapper: ObjectMapper,
) {
    private val logger = LoggerFactory.getLogger(TransactionProcessor::class.java)

    /**
     * https://docs.mollie.com/reference/v2/payments-api/create-payment
     */
    fun initializeTransaction(
        amount: BigDecimal,
        description: String,
        transactionId: Long,
        userId: String
    ): InitializedTransaction {
        val paymentRequest = PaymentRequest()
        paymentRequest.amount = Amount("EUR", amount)
        paymentRequest.description = description
        paymentRequest.redirectUrl = "$callbackUrl?transaction=$transactionId"
        paymentRequest.webhookUrl = Optional.of(webhookUrl)
        paymentRequest.customerReference = Optional.of(userId)

        logger.info("Creating transaction on mollie. Content: {}", objectMapper.writeValueAsString(paymentRequest))

        val response = mollieClient.payments().createPayment(paymentRequest)

        logger.info("Successfully created transaction. Response: {}", objectMapper.writeValueAsString(response))

        return InitializedTransaction(
            molliePaymentReference = response.id,
            checkoutUrl = response.links.checkout.href,
            status = response.status
        )
    }

    fun getMolliePaymentStatus(molliePaymentReference: String?): PaymentStatus {
        val payment = mollieClient.payments().getPayment(molliePaymentReference)

        return payment.status
    }
}

data class InitializedTransaction(
    val molliePaymentReference: String,
    val checkoutUrl: String,
    val status: PaymentStatus
)