package nl.sharerental.be.security

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.oauth2.jwt.Jwt
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter
import org.springframework.security.web.csrf.CookieCsrfTokenRepository
import org.springframework.web.cors.CorsConfiguration
import org.springframework.web.cors.CorsConfigurationSource
import org.springframework.web.cors.UrlBasedCorsConfigurationSource
import java.util.*
import java.util.stream.Collectors


@Configuration
class WebSecurityConfiguration {
    @Bean
    fun filterChain(http: HttpSecurity) =
        http
            .csrf {
                it.ignoringRequestMatchers(
                    "/transactions/mollie-callback",
                    "/contact-form",
                    "/transactions/get-amount-available-for-date",
                    "/transactions/calculate-price",
                    "/transactions",
                    "/search")
                it.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
            }
            .authorizeHttpRequests {
            it
                .anyRequest()
                .permitAll()
        }
            .cors { it.configurationSource(corsConfigurationSource()) }
            .oauth2ResourceServer { oauth2 -> oauth2.jwt { } }
            .build()

    @Bean
    fun corsConfigurationSource(): CorsConfigurationSource {
        val configuration = CorsConfiguration()
        configuration.allowCredentials = true
        configuration.addAllowedOriginPattern("*")
        configuration.addAllowedHeader("*")
        configuration.addAllowedMethod("*")
        val source = UrlBasedCorsConfigurationSource()
        source.registerCorsConfiguration("/**", configuration)
        return source
    }
}