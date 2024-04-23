package nl.sharerental.be.user

import nl.sharerental.be.user.infrastructure.onesignal.OneSignalEmailSender
import nl.sharerental.be.user.infrastructure.onesignal.OneSignalUserCreation
import nl.sharerental.be.user.infrastructure.repository.UserRepository
import org.springframework.stereotype.Service

@Service
class UserService(
    private val userRepository: UserRepository,
    private val oneSignalUserCreation: OneSignalUserCreation,
    private val oneSignalEmailSender: OneSignalEmailSender,
) {

    fun findUserOrCreate(id: String, email: String, name: String?, subscribedToNews: Boolean): User {
        return userRepository.findById(id)
            .orElseGet {
                userRepository.save(
                    User(
                        id = id,
                        email = email,
                        username = name ?: email.substringBefore('@'),
                        signedUpAs = "unknown"
                    )
                ).also { setupMessaging(it, subscribedToNews) }
            }
    }

    private fun setupMessaging(user: User, subscribedToNews: Boolean) {
        oneSignalUserCreation.createNewWebUserInOneSignal(user, subscribedToNews)
        oneSignalEmailSender.sendWelcomeEmail(user)
    }

    fun save(user: User) {
        userRepository.save(user)
    }
}