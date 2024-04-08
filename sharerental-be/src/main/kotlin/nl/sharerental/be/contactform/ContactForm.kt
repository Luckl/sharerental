package nl.sharerental.be.contactform

import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id

@Entity
class ContactForm (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    val name: String?,
    val email: String?,
    val phone: String?,
    val analyticsToken: String?,
    )