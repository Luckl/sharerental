package nl.sharerental.be.contactform.infrastructure

import nl.sharerental.be.contactform.ContactForm
import nl.sharerental.be.contactform.infrastructure.repository.ContactFormRepository
import nl.sharerental.contract.http.ContactFormApi
import nl.sharerental.contract.http.model.ContactForm as HttpContactForm
import org.slf4j.LoggerFactory
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController

class ContactFormController(
    private val contactFormRepository: ContactFormRepository
) : ContactFormApi {
    private val logger = LoggerFactory.getLogger(ContactFormController::class.java)

    override fun sendContactForm(contactForm: HttpContactForm?): ResponseEntity<Void> {
        val entity = ContactForm(
            name = contactForm?.name,
            email = contactForm?.email,
            phone = contactForm?.phone,
            analyticsToken = contactForm?.analyticsToken
        )
        contactFormRepository.save(
            entity
        )

        logger.error("Iemand heeft zijn gegevens achtergelaten: {}", entity.toString())

        return ResponseEntity.ok().build()
    }
}