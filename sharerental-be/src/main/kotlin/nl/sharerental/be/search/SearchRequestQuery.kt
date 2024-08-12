package nl.sharerental.be.search

import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import java.time.Instant

@Entity
data class SearchRequestQuery (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,
    val ipAddress: String,
    val userId: String?,
    val createdAt: Instant = Instant.now(),
    val query: String?,
    val category: String?,
    val searchRequest: String?,
)