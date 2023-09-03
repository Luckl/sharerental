package nl.sharerental.be.user.configuration

import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import nl.sharerental.be.user.CurrentUserService
import org.slf4j.MDC
import org.springframework.stereotype.Service
import org.springframework.web.servlet.HandlerInterceptor

@Service
class UserContextInitializationInterceptor(val currentUserService: CurrentUserService): HandlerInterceptor {

    override fun preHandle(request: HttpServletRequest, response: HttpServletResponse, handler: Any): Boolean {
        val user = currentUserService.init()
        MDC.put("user", user?.id)
        return super.preHandle(request, response, handler)
    }
}