package nl.sharerental.be.lessor

import jakarta.persistence.*
import nl.sharerental.be.user.User

@Entity
@Table(name = "user_lessor")
class UserLessor(

    @EmbeddedId
    var id: UserLessorId? = null,

    @ManyToOne
    @JoinColumn(name = "user_id", updatable = false, insertable = false)
    var user: User? = null,

    @ManyToOne
    @JoinColumn(name = "lessor_id", updatable = false, insertable = false)
    var lessor: Lessor? = null,

    @Column(name = "role")
    var role: String? = null
)