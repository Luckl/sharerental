package nl.sharerental.be.renter

import jakarta.persistence.*

@Entity
data class Renter(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,
    val name: String,
    val description: String?,
    @ManyToOne
    @JoinColumn(name = "primary_location")
    val primaryLocation: Location,

    @ManyToMany
    @JoinTable(
        name = "renter_location",
        joinColumns = [JoinColumn(name = "renter_id")],
        inverseJoinColumns = [JoinColumn(name = "location_id")]
    )
    val renters: Set<Location> = emptySet()
)