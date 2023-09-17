package nl.sharerental.be.lessor

import jakarta.persistence.*
import nl.sharerental.be.rentalitem.FuelType

@Entity
@Table(name = "lessor")
class Lessor (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long? = null,
    val name: String,
    val description: String?,
    val phoneNumber: String?,
    @ManyToOne(cascade = [CascadeType.PERSIST])
    @JoinColumn(name = "primary_location")
    val primaryLocation: Location,

    @Enumerated(EnumType.STRING)
    val status: LessorStatus = LessorStatus.ACTIVE,
    @ManyToMany(cascade = [CascadeType.PERSIST])
    @JoinTable(
        name = "lessor_location",
        joinColumns = [JoinColumn(name = "lessor_id")],
        inverseJoinColumns = [JoinColumn(name = "location_id")]
    )
    val locations: Set<Location> = emptySet(),

    @OneToOne(mappedBy = "lessor", cascade = [CascadeType.ALL])
    var lessorFinancialInformation: LessorFinancialInformation?,

    @OneToMany(mappedBy = "lessor", cascade = [CascadeType.PERSIST])
    var userLessors: Set<UserLessor> = setOf()
)

enum class LessorStatus {
ACTIVE, INACTIVE;
}
