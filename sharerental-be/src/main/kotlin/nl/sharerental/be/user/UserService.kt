package nl.sharerental.be.user

import nl.sharerental.be.user.infrastructure.onesignal.OneSignalClient
import nl.sharerental.be.user.infrastructure.repository.UserRepository
import org.springframework.stereotype.Service

@Service
class UserService(
    private val userRepository: UserRepository,
    private val oneSignalClient: OneSignalClient,
) {

    fun findUserOrCreate(id: String, email: String, name: String, subscribedToNews: Boolean): User {
        return userRepository.findById(id)
            .orElseGet {
                userRepository.save(
                    User(
                        id = id,
                        email = email,
                        username = name
                    )
                ).also { setupMessaging(it, subscribedToNews) }
            }
    }

    private fun setupMessaging(user: User, subscribedToNews: Boolean) {
        oneSignalClient.createNewWebUserInOneSignal(user, subscribedToNews)
        oneSignalClient.sendWelcomeEmail(user)
    }
}