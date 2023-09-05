package nl.sharerental.be.user.configuration

import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.apache.commons.lang3.StringUtils
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import org.springframework.web.servlet.HandlerInterceptor
import org.springframework.web.servlet.ModelAndView
import java.util.*


@Component
class RequestResponseLoggingInterceptor() : HandlerInterceptor {
    private val logger: Logger = LoggerFactory.getLogger(RequestResponseLoggingInterceptor::class.java)
    override fun preHandle(request: HttpServletRequest, response: HttpServletResponse, handler: Any): Boolean {
        logger.info(
            "[preHandle][${request.method}]${request.requestURI}${getParameters(request)}"
        )
        return true
    }

    override fun postHandle(
        request: HttpServletRequest, response: HttpServletResponse, handler: Any,
        modelAndView: ModelAndView?
    ) {
        logger.info("[postHandle][${request.requestURI}]")
    }

    override fun afterCompletion(
        request: HttpServletRequest, response: HttpServletResponse, handler: Any,
        ex: Exception?
    ) {
        ex?.printStackTrace()
        logger.info("[afterCompletion][${response.status}][exception: $ex]")
    }

    private fun getParameters(request: HttpServletRequest): String {
        val posted = StringBuilder()
        val e: Enumeration<*>? = request.parameterNames
        if (e != null) {
            posted.append("?")
        }
        while (e!!.hasMoreElements()) {
            if (posted.length > 1) {
                posted.append("&")
            }
            val curr = e.nextElement() as String
            posted.append(curr).append("=")
            if ((curr.contains("password")
                        || curr.contains("answer")
                        || curr.contains("pwd"))
            ) {
                posted.append("*****")
            } else {
                posted.append(request.getParameter(curr))
            }
        }
        val ip = request.getHeader("X-FORWARDED-FOR")
        val ipAddr = ip ?: getRemoteAddr(request)
        if (!StringUtils.isEmpty(ipAddr)) {
            posted.append("&_psip=$ipAddr")
        }
        return posted.toString()
    }

    private fun getRemoteAddr(request: HttpServletRequest): String {
        val ipFromHeader = request.getHeader("X-FORWARDED-FOR")
        return if (ipFromHeader != null && ipFromHeader.length > 0) {
            ipFromHeader
        } else request.remoteAddr
    }
}