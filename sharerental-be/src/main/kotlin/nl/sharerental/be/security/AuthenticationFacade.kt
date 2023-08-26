package nl.sharerental.be.security

import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Service

@Service
class AuthenticationFacade {
    fun getPrincipal(): Any? {
        return SecurityContextHolder.getContext().authentication.principal
    }
     fun getCredentials(): Any? {
        return SecurityContextHolder.getContext().authentication.credentials
    }
     fun getGrantedAuthorities(): Any? {
        return SecurityContextHolder.getContext().authentication.authorities
    }
     fun getDetails(): Any? {
        return SecurityContextHolder.getContext().authentication.details
    }
     fun getAuthenticated(): Boolean {
        return SecurityContextHolder.getContext().authentication.isAuthenticated
    }

}