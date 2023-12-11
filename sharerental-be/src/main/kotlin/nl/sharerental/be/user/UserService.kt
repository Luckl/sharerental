package nl.sharerental.be.user

import nl.sharerental.be.user.infrastructure.repository.UserRepository
import org.springframework.stereotype.Service

@Service
class UserService(private val userRepository: UserRepository) {

    fun findUserOrCreate(id: String, email: String): User {
        return userRepository.findById(id)
            .orElseGet {
                userRepository.save(
                    User(
                        id = id,
                        email = email
                    )
                ).also { sendWelcomeEmail(email) }
            }
    }

    private fun sendWelcomeEmail(email: String) {
        // Send welcome email
    }
}