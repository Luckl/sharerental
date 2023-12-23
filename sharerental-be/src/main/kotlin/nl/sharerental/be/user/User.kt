package nl.sharerental.be.user

import jakarta.persistence.*
import nl.sharerental.be.lessor.UserLessor

@Entity
@Table(name = "usr")
class User(

    @Id
    val id: String,
    val email: String,
    val username: String = email.substringBefore('@'),
    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
    var userLessors: Set<UserLessor> = setOf()
)