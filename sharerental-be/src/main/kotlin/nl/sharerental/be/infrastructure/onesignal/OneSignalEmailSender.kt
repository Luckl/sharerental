package nl.sharerental.be.infrastructure.onesignal

import com.fasterxml.jackson.annotation.JsonProperty
import com.fasterxml.jackson.databind.ObjectMapper
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
    @Value("\${one-signal.templates.item-rented-renter}") private val itemRentedRenterEmailTemplate: String,
    @Value("\${one-signal.mock}") private val mock: Boolean,
    private val objectMapper: ObjectMapper,
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

    fun sendItemRentedEmailToLessor(transaction: Transaction) {
        logger.info("Sending item rented email to users of lessor ${transaction.rentalItem.owner.id}")
        val userEmails = transaction.rentalItem.owner.userLessors.mapNotNull { it.user?.email }
        val body = OneSignalEmailRequest(
            includeEmailTokens = userEmails,
            appId = appId,
            templateId = itemRentedEmailTemplate,
            customData = ItemRentedLessorEmailCustomData(
                recipientName = transaction.rentalItem.owner.name,
                renterName = "${transaction.renter.firstName} ${transaction.renter.lastName}",
                rentalItemName = transaction.rentalItem.name,
                rentalItemReference = transaction.rentalItem.externalReference?: "",
                amount = transaction.amount.toString(),
                startDate = transaction.startDate.format(DateTimeFormatter.ofPattern("dd MMM yyyy")),
                endDate = transaction.endDate.format(DateTimeFormatter.ofPattern("dd MMM yyyy")),
                price = transaction.price.setScale(2, RoundingMode.HALF_UP).toString(),
                )
        )

        sendEmail(body)
    }

    fun sendTransactionSuccessfulEmailToRenter(transaction: Transaction) {
        logger.info("Sending item rented email to renter ${transaction.renter.id}")
        val userEmail = transaction.renter.email

        val body = OneSignalEmailRequest(
            includeEmailTokens = listOf(userEmail),
            appId = appId,
            templateId = itemRentedRenterEmailTemplate,
            customData = ItemRentedRenterEmailCustomData(
                recipientName = transaction.renter.firstName,
                lessorName = transaction.rentalItem.owner.name,
                rentalItemName = transaction.rentalItem.name,
                startDate = transaction.startDate.format(DateTimeFormatter.ofPattern("dd MMM yyyy")),
                endDate = transaction.endDate.format(DateTimeFormatter.ofPattern("dd MMM yyyy")),
                lessorCity = transaction.rentalItem.owner.primaryLocation.city,
                lessorStreet = transaction.rentalItem.owner.primaryLocation.street,
                lessorHouseNumber = transaction.rentalItem.owner.primaryLocation.houseNumber,
                lessorPostalCode = transaction.rentalItem.owner.primaryLocation.postalCode,
                )
        )

        sendEmail(body)
    }

    private fun sendEmail(body: OneSignalEmailRequest) {
        val bodyString = objectMapper.writeValueAsString(body)
        if (mock) {
            logger.info("MOCK WebClient POST request body: $bodyString")
        } else {
            logger.debug("WebClient POST request body: {}", bodyString)
            val result = oneSignalWebClient.post()
                .uri("notifications")
                .contentType(APPLICATION_JSON)
                .accept(APPLICATION_JSON)
                .bodyValue(body)
                .retrieve()
                .bodyToMono(OneSignalEmailResponse::class.java)
                .block()

            if (result?.errors?.isNotEmpty() == true) {
                logger.error("Error sending email: {}", result)
            }
        }
    }
}

data class OneSignalEmailRequest(
    @JsonProperty("include_email_tokens")
    val includeEmailTokens: List<String>,
    @JsonProperty("app_id")
    val appId: String,
    @JsonProperty("template_id")
    val templateId: String,
    @JsonProperty("custom_data")
    val customData: CustomData,
) {
    @JsonProperty("include_unsubscribed")
    val includeUnsubscribed = true
}

interface CustomData

data class WelcomeEmailCustomData(
    val username: String,
) : CustomData

data class OneSignalEmailResponse(
    val id: String,
    val errors: Map<String, List<String>>,
)

data class ItemRentedLessorEmailCustomData(
    val recipientName: String,
    val renterName: String,
    val rentalItemName: String,
    val rentalItemReference: String,
    val amount: String,
    val price: String,
    val startDate: String,
    val endDate: String,
) : CustomData
data class ItemRentedRenterEmailCustomData(
    val recipientName: String,
    val lessorName: String,
    val rentalItemName: String,
    val startDate: String,
    val endDate: String,
    val lessorCity: String?,
    val lessorStreet: String?,
    val lessorHouseNumber: String?,
    val lessorPostalCode: String?,
) : CustomData