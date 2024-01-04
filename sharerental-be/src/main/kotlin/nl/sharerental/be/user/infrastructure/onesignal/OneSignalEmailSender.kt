package nl.sharerental.be.user.infrastructure.onesignal

import nl.sharerental.be.transaction.Transaction
import nl.sharerental.be.user.User
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.http.MediaType.APPLICATION_JSON
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.WebClient
import java.math.RoundingMode
import java.time.format.DateTimeFormatter

@Service
class OneSignalEmailSender(
    private val oneSignalWebClient: WebClient,
    @Value("\${one-signal.app-id}") private val appId: String,
    @Value("\${one-signal.templates.welcome-email}") private val welcomeEmailTemplateId: String,
    @Value("\${one-signal.templates.item-rented}") private val itemRentedEmailTemplate: String,
    @Value("\${one-signal.mock}") private val mock: Boolean,
) {
    private val logger: Logger = LoggerFactory.getLogger(OneSignalEmailSender::class.java)

    fun sendWelcomeEmail(user: User) {
        logger.info("Sending welcome email to user ${user.id}")
        val body = OneSignalEmailRequest(
            includeEmailTokens = listOf(user.email),
            appId = appId,
            templateId = welcomeEmailTemplateId,
            customData = WelcomeEmailCustomData(
                username = user.username,
            )
        )

        sendEmail(body)
    }

    fun sendItemRentedEmail(transaction: Transaction) {
        logger.info("Sending item rented email to user ${transaction.rentalItem.owner.id}")
        val userEmails = transaction.rentalItem.owner.userLessors.mapNotNull { it.user?.email }
        val body = OneSignalEmailRequest(
            includeEmailTokens = userEmails,
            appId = appId,
            templateId = itemRentedEmailTemplate,
            customData = ItemRentedEmailCustomData(
                recipientName = transaction.rentalItem.owner.name,
                renterName = transaction.renter.username,
                rentalItemName = transaction.rentalItem.name,
                rentalItemReference = transaction.rentalItem.number?: "",
                amount = transaction.amount.toString(),
                startDate = transaction.startDate.format(DateTimeFormatter.ofPattern("dd MMM yyyy")),
                endDate = transaction.endDate.format(DateTimeFormatter.ofPattern("dd MMM yyyy")),
                price = transaction.price.setScale(2, RoundingMode.HALF_UP).toString(),
                )
        )

        sendEmail(body)
    }

    private fun sendEmail(body: OneSignalEmailRequest) {
        if (mock) {
            logger.info("MOCK WebClient POST request body: $body")
        } else {
            logger.debug("WebClient POST request body: {}", body)
            oneSignalWebClient.post()
                .uri("notifications")
                .contentType(APPLICATION_JSON)
                .accept(APPLICATION_JSON)
                .bodyValue(body)
                .retrieve()
                .bodyToMono(String::class.java)
                .block()
        }
    }
}

/**
 * {
 *   "include_email_tokens": [
 *     "${user.email}"
 *   ],
 *   "app_id": "$appId",
 *   "template_id": "$welcomeEmailTemplateId",
 *   "include_unsubscribed": true,
 *   "custom_data": {
 *     "username": "${user.username}"
 *   }
 * }
 */
data class OneSignalEmailRequest(
    val includeEmailTokens: List<String>,
    val appId: String,
    val templateId: String,
    val customData: CustomData,
) {
    val includeUnsubscribed = true
}

interface CustomData;

data class WelcomeEmailCustomData(
    val username: String,
) : CustomData

data class ItemRentedEmailCustomData(
    val recipientName: String,
    val renterName: String,
    val rentalItemName: String,
    val rentalItemReference: String,
    val amount: String,
    val price: String,
    val startDate: String,
    val endDate: String,
) : CustomData