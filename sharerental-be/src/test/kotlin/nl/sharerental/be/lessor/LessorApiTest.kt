package nl.sharerental.be.lessor

import io.zonky.test.db.AutoConfigureEmbeddedDatabase
import nl.sharerental.be.lessor.infrastructure.repository.LessorRepository
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.test.mock.mockito.MockBean
import org.springframework.security.oauth2.jwt.JwtDecoder
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post
import org.springframework.test.web.servlet.request.RequestPostProcessor
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import org.springframework.transaction.PlatformTransactionManager
import org.springframework.transaction.support.TransactionTemplate


@SpringBootTest
@AutoConfigureMockMvc
@AutoConfigureEmbeddedDatabase
class LessorApiTest {

    @Autowired
    private lateinit var mockMvc: MockMvc

    @MockBean
    private lateinit var jwtDecoder: JwtDecoder

    @Autowired
    private lateinit var transactionManager: PlatformTransactionManager

    private lateinit var transactionTemplate: TransactionTemplate

    @Autowired
    private lateinit var lessorRepository: LessorRepository

    private val description = "Machineverhuur voor iedereen!"
    private val name = "Franskes machineverhuur"

   fun setup() {
        transactionTemplate = TransactionTemplate(transactionManager)
    }

    fun createLessor() {

        val request = """
            {
            "name": "$name",
            "description": "$description",
            "addressLine1": "string",
            "addressLine2": "string",
            "addressLine3": "string",
            "street": "string",
            "houseNumber": "string",
            "houseNumberAddition": "string",
            "postalCode": "string",
            "city": "string",
            "country": "string"
            }
        """
        request.trimIndent()
        mockMvc.perform(
            post("/me/lessor")
                .with(jwtRequestPostProcessor())
                .contentType("application/json")
                .content(request)
        )
            .andExpect(status().isOk)


        transactionTemplate.execute {
            val first = lessorRepository.findAll().first()

            assertThat(first.description).isEqualTo(description)
            assertThat(first.name).isEqualTo(name)
            assertThat(first.userLessors).hasSize(1)
        }
    }

    private fun jwtRequestPostProcessor(): RequestPostProcessor =
        SecurityMockMvcRequestPostProcessors
            .jwt()
            .jwt { builder ->
                builder
                    .claim("user_id", "mockMvcTest")
                    .claim("email", "mock@sharerental.nl")
            }
}