package nl.sharerental.be.user.infrastructure

import nl.sharerental.be.infrastructure.slack.SlackClient
import nl.sharerental.be.jooq.generated.tables.references.RENTER
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.be.user.infrastructure.repository.UserRepository
import nl.sharerental.contract.http.UserApi
import nl.sharerental.contract.http.model.User
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class UserController(
    private val userRepository: UserRepository,
    private val currentUserService: CurrentUserService,
    private val slackClient: SlackClient,
): UserApi {
    override fun registerUser(user: User?): ResponseEntity<Void> {
        val usr = currentUserService.get()
        usr
            .apply { this.signedUpAs = user?.userType.toString() }
            .also { userRepository.save(it) }

        slackClient.sendSlackMessage("User registered: ${usr.email} heeft zich geregistreerd als ${if (usr.signedUpAs.equals(RENTER)) "huurder" else "verhuurder"}")

        return ResponseEntity.ok().build()
    }
}