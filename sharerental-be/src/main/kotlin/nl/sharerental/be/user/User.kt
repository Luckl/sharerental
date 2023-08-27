package nl.sharerental.be.user

import jakarta.persistence.*
import nl.sharerental.be.lessor.Lessor

@Entity
@Table(name = "usr")
data class User(

    @Id
    val id: String,
    val name: String?,
    val surname: String?,
    val email: String,
    @Column(name = "phone_number")
    val phoneNumber: String?,

    @ManyToMany
    @JoinTable(
        name = "user_lessor",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "lessor_id")]
    )
    val lessors: Set<Lessor> = emptySet()
)