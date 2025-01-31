package nl.sharerental.be.blog

import jakarta.persistence.Entity
import jakarta.persistence.Id
import nl.sharerental.be.infrastructure.seobotai.Category

@Entity
data class BlogCategory(
    @Id
    var id: String,
    var title: String,
    var slug: String

)