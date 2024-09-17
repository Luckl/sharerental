package nl.sharerental.be.blog

import jakarta.persistence.Entity
import jakarta.persistence.Id
import nl.sharerental.be.infrastructure.seobotai.Tag

@Entity
data class BlogTag(
    @Id
    var id: String,
    var title: String,
    var slug: String
) {
    companion object {
        fun fromSeoBotTag(it: Tag): BlogTag = BlogTag (
            id = it.id,
            title = it.title,
            slug = it.slug
        )
    }

}