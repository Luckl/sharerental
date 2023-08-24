package nl.sharerental.be.security

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.builders.HttpSecurity


@Configuration
class WebSecurityConfiguration {
    @Bean
    fun filterChain(http: HttpSecurity) =
        http.authorizeHttpRequests {
            it.anyRequest()
                .anonymous()
        }
            .oauth2ResourceServer { oauth2 -> oauth2.jwt { } }
            .build()

}