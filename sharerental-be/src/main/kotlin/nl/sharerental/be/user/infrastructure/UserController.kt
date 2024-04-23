package nl.sharerental.be.user.infrastructure

import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.be.user.infrastructure.repository.UserRepository
import nl.sharerental.contract.http.UserApi
import nl.sharerental.contract.http.model.User
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class UserController(
    private val userRepository: UserRepository,
    private val currentUserService: CurrentUserService
): UserApi {
    override fun registerUser(user: User?): ResponseEntity<Void> {
        currentUserService.get()
            .apply { this.signedUpAs = user?.userType.toString() }
            .also { userRepository.save(it) }
        return ResponseEntity.ok().build()
    }
}