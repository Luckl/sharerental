package nl.sharerental.be.user

import jakarta.persistence.*
import nl.sharerental.be.lessor.UserLessor

@Entity
@Table(name = "usr")
class User(

    @Id
    val id: String,
    val email: String,
    var username: String,
    @OneToOne(cascade = [CascadeType.ALL], fetch = FetchType.LAZY)
    @JoinColumn(name = "renter_information", referencedColumnName = "id")
    var renterInformation: Renter? = null,
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    var userLessors: Set<UserLessor> = setOf(),
    var signedUpAs: String
)