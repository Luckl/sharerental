package nl.sharerental.be.lessor

import jakarta.persistence.*
import nl.sharerental.be.user.User

@Entity
@Table(name = "lessor")
class LessorEntity (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long? = null,
    val name: String,
    val description: String?,
    val phoneNumber: String?,
    @ManyToOne(cascade = [CascadeType.PERSIST])
    @JoinColumn(name = "primary_location")
    val primaryLocation: Location,

    @ManyToMany(cascade = [CascadeType.PERSIST])
    @JoinTable(
        name = "lessor_location",
        joinColumns = [JoinColumn(name = "lessor_id")],
        inverseJoinColumns = [JoinColumn(name = "location_id")]
    )
    val locations: Set<Location> = emptySet(),

    @OneToOne(mappedBy = "lessorEntity")
    var lessorFinancialInformation: LessorFinancialInformation?,

    @ManyToMany(cascade = [CascadeType.PERSIST])
    @JoinTable(
        name = "user_lessor",
        joinColumns = [JoinColumn(name = "lessor_id")],
        inverseJoinColumns = [JoinColumn(name = "user_id")]
    )
    var users: Set<User> = emptySet()

)