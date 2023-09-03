package nl.sharerental.be.user

import jakarta.persistence.*
import nl.sharerental.be.lessor.UserLessor

@Entity
@Table(name = "usr")
class User(

    @Id
    val id: String,
    val name: String?,
    val surname: String?,
    val email: String,
    @Column(name = "phone_number")
    val phoneNumber: String?,
    @OneToMany(mappedBy = "user")
    var userLessors: Set<UserLessor> = setOf()
) {

}