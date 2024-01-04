package nl.sharerental.be.lessor

import jakarta.persistence.Column
import jakarta.persistence.Embeddable
import java.io.Serializable

@Embeddable
class UserLessorId(
    @Column(name = "user_id", nullable = false)
    var userId: String? = null,

    @Column(name = "lessor_id", nullable = false)
    var lessorId: Long? = null
): Serializable {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as UserLessorId

        if (userId != other.userId) return false
        if (lessorId != other.lessorId) return false

        return true
    }

    override fun hashCode(): Int {
        var result = userId?.hashCode() ?: 0
        result = 31 * result + (lessorId?.hashCode() ?: 0)
        return result
    }
}