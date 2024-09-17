package nl.sharerental.be.blog

import jakarta.persistence.CascadeType
import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.ManyToMany
import jakarta.persistence.ManyToOne
import nl.sharerental.be.infrastructure.seobotai.RelatedPost
import nl.sharerental.be.infrastructure.seobotai.SingleArticleResponse

@Entity
data class BlogArticle(
    @Id
    var id: String,
    var slug: String,
    var headline: String,
    var metaDescription: String,
    var metaKeywords: String,
    var html: String,
    var outline: String,
    var deleted: Boolean,
    var published: Boolean,

    @ManyToMany(cascade = [CascadeType.ALL])
    var tags: List<BlogTag>,

    @ManyToOne(cascade = [CascadeType.ALL])
    var category: BlogCategory,
    var readingTime: Int,
    var publishedAt: String,
    @ManyToMany(cascade = [])
    var relatedPosts: List<BlogArticle>
) {
    companion object {
        fun fromSeoBotArticle(articleById: SingleArticleResponse): BlogArticle {
            return BlogArticle(
                id = articleById.data.article.id,
                slug = articleById.data.article.slug,
                headline = articleById.data.article.headline,
                html = articleById.data.article.html,
                outline = articleById.data.article.outline,
                deleted = articleById.data.article.deleted,
                published = articleById.data.article.published,
                metaKeywords = articleById.data.article.metaKeywords,
                metaDescription = articleById.data.article.metaDescription,
                tags = articleById.data.article.tags.map { BlogTag.fromSeoBotTag(it) },
                category = BlogCategory.fromSeoBotCategory(articleById.data.article.category),
                readingTime = articleById.data.article.readingTime,
                publishedAt = articleById.data.article.publishedAt,
                relatedPosts = articleById.data.article.relatedPosts.map { fromSeoBotRelatedPost(it) }
            )
        }

        private fun fromSeoBotRelatedPost(it: RelatedPost) =
            BlogArticle(
                id = it.id,
                slug = it.slug,
                headline = it.headline
            )

    }

    constructor(id: String, slug: String, headline: String) : this(
        id,
        slug,
        headline,
        "",
        "",
        "",
        "",
        false,
        false,
        emptyList(),
        BlogCategory("", "", ""),
        0,
        "",
        emptyList()
    )
}