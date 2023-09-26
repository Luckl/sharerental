package nl.sharerental.be.user.configuration

import org.springframework.context.annotation.Configuration
import org.springframework.web.servlet.config.annotation.InterceptorRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer

@Configuration
class UserConfiguration(val userInitializationInterceptor: UserContextInitializationInterceptor, val requestResponseLoggingInterceptor: RequestResponseLoggingInterceptor): WebMvcConfigurer {
    override fun addInterceptors(registry: InterceptorRegistry) {
//        registry.addInterceptor(requestResponseLoggingInterceptor)
        registry.addInterceptor(userInitializationInterceptor)
    }
}