package nl.sharerental.be.user

import nl.sharerental.be.security.AuthenticationFacade
import nl.sharerental.be.user.repository.UserRepository
import org.springframework.context.annotation.Scope
import org.springframework.context.annotation.ScopedProxyMode
import org.springframework.security.oauth2.jwt.Jwt
import org.springframework.stereotype.Service
import org.springframework.web.context.WebApplicationContext

@Service
@Scope(value = WebApplicationContext.SCOPE_REQUEST, proxyMode = ScopedProxyMode.TARGET_CLASS)
class CurrentUserService(val userRepository: UserRepository, val authentication: AuthenticationFacade) {

    // Could be improved by storing User object as field since service is request scoped.
    fun get(): User? {
        val user = when (val principal = authentication.getPrincipal()) {
            is Jwt -> processJwt(principal)
            else -> null
        }

        return user
    }

    private fun processJwt(principal: Jwt): User {
        val userId = principal.claims["user_id"] as String
        val email = principal.claims["email"] as String

        return userRepository.findById(userId)
            .orElse(
                userRepository.save(
                    User(
                        id = userId,
                        email = email,
                        name = null,
                        phoneNumber = null,
                        renters = emptySet(),
                        surname = null
                    )
                )
            )
    }
}
