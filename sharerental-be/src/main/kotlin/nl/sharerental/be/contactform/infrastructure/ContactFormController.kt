package nl.sharerental.be.contactform.infrastructure

import com.fasterxml.jackson.databind.ObjectMapper
import nl.sharerental.be.contactform.ContactForm
import nl.sharerental.be.contactform.infrastructure.repository.ContactFormRepository
import nl.sharerental.be.infrastructure.slack.SlackClient
import nl.sharerental.contract.http.ContactFormApi
import nl.sharerental.contract.http.model.ContactForm as HttpContactForm
import org.slf4j.LoggerFactory
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController

class ContactFormController(
    private val contactFormRepository: ContactFormRepository,
    private val slackClient: SlackClient,
    private val objectMapper: ObjectMapper
) : ContactFormApi {

    override fun sendContactForm(contactForm: HttpContactForm?): ResponseEntity<Void> {
        val entity = ContactForm(
            name = contactForm?.name,
            email = contactForm?.email,
            phone = contactForm?.phone,
            analyticsToken = contactForm?.analyticsToken,
            message = contactForm?.message
        )
        contactFormRepository.save(entity)

        logger.info("Received contact form: {}", objectMapper.writeValueAsString(entity))

        slackClient.sendSlackMessage("${entity.name} heeft het volgende bericht achter gelaten: ${entity.message}. Email: ${entity.email} en telefoonnummer: ${entity.phone}")

        return ResponseEntity.ok().build()
    }
}