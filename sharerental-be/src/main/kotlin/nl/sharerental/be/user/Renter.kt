package nl.sharerental.be.user

import jakarta.persistence.*
import nl.sharerental.be.lessor.Location
import nl.sharerental.be.user.User
import nl.sharerental.contract.http.model.RenterInput
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
)