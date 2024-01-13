package nl.sharerental.be.user

import jakarta.persistence.*
import nl.sharerental.be.lessor.Location
import nl.sharerental.be.user.User
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
)