package nl.sharerental.be.lessor.infrastructure

import nl.sharerental.be.lessor.UserLessor
import nl.sharerental.be.lessor.UserLessorId
import org.springframework.data.repository.CrudRepository

interface UserLessorRepository: CrudRepository<UserLessor, UserLessorId> {


}