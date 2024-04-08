package nl.sharerental.be.contactform.infrastructure.repository

import nl.sharerental.be.contactform.ContactForm
import nl.sharerental.be.lessor.Lessor
import org.springframework.data.repository.CrudRepository

interface ContactFormRepository: CrudRepository<ContactForm, Long> {
}