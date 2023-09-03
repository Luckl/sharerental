package nl.sharerental.be.lessor

import jakarta.persistence.Column
import jakarta.persistence.Embeddable

@Embeddable
class UserLessorId(
    @Column(name = "user_id", nullable = false)
    var userId: String? = null,

    @Column(name = "lessor_id", nullable = false)
    var lessorId: Long? = null
)