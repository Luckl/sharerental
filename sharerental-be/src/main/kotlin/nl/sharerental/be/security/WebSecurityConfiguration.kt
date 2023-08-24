package nl.sharerental.be.security

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.web.cors.CorsConfiguration
import org.springframework.web.cors.CorsConfigurationSource
import org.springframework.web.cors.UrlBasedCorsConfigurationSource


@Configuration
class WebSecurityConfiguration {
    @Bean
    fun filterChain(http: HttpSecurity) =
        http.authorizeHttpRequests {
            it
                .requestMatchers("/me/**")
                .authenticated()
                .anyRequest()
                .anonymous()
        }
            .cors { it.configurationSource(corsConfigurationSource()) }
            .oauth2ResourceServer { oauth2 -> oauth2.jwt { } }
            .build()

    @Bean
    fun corsConfigurationSource(): CorsConfigurationSource {
        val configuration = CorsConfiguration()
        configuration.allowCredentials = true;
        configuration.addAllowedOriginPattern("*");
        configuration.addAllowedHeader("*");
        configuration.addAllowedMethod("*");
        val source = UrlBasedCorsConfigurationSource()
        source.registerCorsConfiguration("/**", configuration)
        return source
    }
}