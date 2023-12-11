package nl.sharerental.be.user

import nl.sharerental.be.user.infrastructure.onesignal.OneSignal
import nl.sharerental.be.user.infrastructure.repository.UserRepository
import org.springframework.stereotype.Service

@Service
class UserService(
    private val userRepository: UserRepository,
    private val oneSignal: OneSignal,
) {

    fun findUserOrCreate(id: String, email: String, subscribedToNews: Boolean): User {
        return userRepository.findById(id)
            .orElseGet {
                userRepository.save(
                    User(
                        id = id,
                        email = email
                    )
                ).also { setupMessaging(it, subscribedToNews) }
            }
    }

    private fun setupMessaging(user: User, subscribedToNews: Boolean) {
        oneSignal.createNewWebUserInOneSignal(user, subscribedToNews)
        oneSignal.sendWelcomeEmail(user)
    }
}