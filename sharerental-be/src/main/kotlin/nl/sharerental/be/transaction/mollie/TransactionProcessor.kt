package nl.sharerental.be.transaction.mollie

import be.woutschoovaerts.mollie.Client
import be.woutschoovaerts.mollie.data.common.Amount
import be.woutschoovaerts.mollie.data.payment.PaymentRequest
import be.woutschoovaerts.mollie.data.payment.PaymentStatus
import org.springframework.beans.factory.annotation.Value
import java.math.BigDecimal
import java.util.*

class TransactionProcessor(
    private val mollieClient: Client,
    @Value("\${shareRental.callbackUrl}")
    private val callbackUrl: String,

    @Value("\${shareRental.webhookUrl}")
    private val webhookUrl: String,

    ) {

    fun initializeTransaction(amount: BigDecimal, description: String, transactionId: Long, userId: String): InitializedTransaction {
        val paymentRequest = PaymentRequest()
        paymentRequest.amount = Amount("EUR", amount)
        paymentRequest.description = description
        paymentRequest.redirectUrl = "$callbackUrl?transaction=$transactionId"
        paymentRequest.webhookUrl = Optional.of(webhookUrl)
        paymentRequest.customerReference = Optional.of(userId)

        val response = mollieClient.payments().createPayment(
            paymentRequest
        )

        return InitializedTransaction(
            paymentReference = response.id,
            checkoutUrl = response.links.checkout.href,
            status = response.status
        )
    }
}

data class InitializedTransaction(val paymentReference: String,
                                  val checkoutUrl: String,
                                  val status: PaymentStatus)