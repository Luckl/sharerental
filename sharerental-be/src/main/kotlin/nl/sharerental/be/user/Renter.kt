package nl.sharerental.be.user

import jakarta.persistence.*
import nl.sharerental.be.lessor.Location
import nl.sharerental.contract.http.model.Renter as HttpRenter
import java.time.Instant

@Entity
data class Renter(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,
    @Column(name = "first_name")
    val firstName: String,
    @Column(name = "last_name")
    val lastName: String?,
    @Column(name = "phone_number")
    val phoneNumber: String?,
    @Column(name = "email")
    val email: String,
    @OneToOne(cascade = [CascadeType.ALL])
    val location: Location? = null,
    @Column(name = "created_at")
    val createdAt: Instant = Instant.now(),
    @OneToOne(cascade = [CascadeType.PERSIST])
    @JoinColumn(name = "entered_by_user", referencedColumnName = "id")
    val createdByUser: User? = null,
    @Enumerated(EnumType.STRING)
    val renterType: RenterType = RenterType.PRIVATE,
    val companyName: String? = null,
    val chamberOfCommerce: String? = null,
    val vatNumber: String? = null,
) {
    fun toResponse(): HttpRenter {
        val renter = HttpRenter()

        renter.firstName = firstName
        renter.lastName = lastName
        renter.phoneNumber = phoneNumber
        renter.id = id
        renter.email = email
        renter.location = location?.toResponse()
        renter.renterType = nl.sharerental.contract.http.model.RenterType.valueOf(renterType.name)
        renter.chamberOfCommerce = chamberOfCommerce
        renter.companyName = companyName
        renter.vatNumber = vatNumber

        return renter
    }
}

enum class RenterType {
    PRIVATE,
    BUSINESS
}