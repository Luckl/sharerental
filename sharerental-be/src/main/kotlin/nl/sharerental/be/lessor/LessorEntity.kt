package nl.sharerental.be.lessor

import jakarta.persistence.*

@Entity
@Table(name = "lessor")
data class LessorEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long? = null,
    val name: String,
    val description: String?,
    @ManyToOne(cascade = [CascadeType.PERSIST])
    @JoinColumn(name = "primary_location")
    val primaryLocation: Location,

    @ManyToMany(cascade = [CascadeType.PERSIST])
    @JoinTable(
        name = "lessor_location",
        joinColumns = [JoinColumn(name = "lessor_id")],
        inverseJoinColumns = [JoinColumn(name = "location_id")]
    )
    val locations: Set<Location> = emptySet()
)