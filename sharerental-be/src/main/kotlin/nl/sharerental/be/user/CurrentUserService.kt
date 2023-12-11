package nl.sharerental.be.user

import nl.sharerental.be.security.AuthenticationFacade
import nl.sharerental.be.user.infrastructure.repository.UserRepository
import org.springframework.context.annotation.Scope
import org.springframework.context.annotation.ScopedProxyMode
import org.springframework.http.HttpStatus
import org.springframework.security.oauth2.jwt.Jwt
import org.springframework.stereotype.Service
import org.springframework.web.context.WebApplicationContext
import org.springframework.web.server.ResponseStatusException

@Service
@Scope(value = WebApplicationContext.SCOPE_REQUEST, proxyMode = ScopedProxyMode.TARGET_CLASS)
class CurrentUserService(private val userService: UserService,
                         private val authentication: AuthenticationFacade) {

    private lateinit var currentUser: User

    // Could be improved by storing User object as field since service is request scoped.
    fun init(): User? {
        val user = when (val principal = authentication.getPrincipal()) {
            is Jwt -> processJwt(principal)
            else -> null
        }

        return user
    }

    fun get(): User {
        if (!this::currentUser.isInitialized) {
            return init().takeIf { it != null } ?: throw ResponseStatusException(HttpStatus.UNAUTHORIZED)
        }
        return currentUser
    }

    private fun processJwt(principal: Jwt): User {
        val userId = principal.claims["user_id"] as String
        val email = principal.claims["email"] as String

        return userService.findUserOrCreate(userId, email, true)
    }
}
