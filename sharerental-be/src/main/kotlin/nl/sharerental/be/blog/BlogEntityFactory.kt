package nl.sharerental.be.blog

import nl.sharerental.be.blog.infrastructure.repository.BlogArticleRepository
import nl.sharerental.be.blog.infrastructure.repository.BlogCategoryRepository
import nl.sharerental.be.blog.infrastructure.repository.BlogTagRepository
import org.springframework.stereotype.Component

@Component
class BlogEntityFactory(
    private val blogArticleRepository: BlogArticleRepository,
    private val blogTagRepository: BlogTagRepository,
    private val blogCategoryRepository: BlogCategoryRepository
) {

    /**
     * Finds or creates a BlogCategory.
     */
    fun findOrCreateCategory(category: nl.sharerental.be.infrastructure.seobotai.Category): BlogCategory {
        return blogCategoryRepository.findById(category.id).orElseGet {
            BlogCategory(
                id = category.id,
                title = category.title,
                slug = category.slug
            )
        }
    }

    /**
     * Finds or creates a BlogTag.
     */
    fun findOrCreateTag(tag: nl.sharerental.be.infrastructure.seobotai.Tag): BlogTag {
        return blogTagRepository.findById(tag.id).orElseGet {
            BlogTag(
                id = tag.id,
                title = tag.title,
                slug = tag.slug
            )
        }
    }

    /**
     * Finds or creates a BlogArticle.
     */
    fun findOrCreateArticle(article: nl.sharerental.be.infrastructure.seobotai.RelatedPost): BlogArticle {
        return blogArticleRepository.findById(article.id).orElseGet {
            BlogArticle(
                id = article.id,
                slug = article.slug,
                headline = article.headline,
                metaDescription = "",
                metaKeywords = "",
                html = "",
                outline = "",
                deleted = false,
                published = false,
                tags = emptyList(),
                category = BlogCategory("", "", ""),
                readingTime = 0,
                publishedAt = "1970-01-01T00:00:00Z",
                relatedPosts = emptyList()
            )
        }
    }

    /**
     * Converts and saves a full BlogArticle from a SingleArticleResponse.
     */
    fun createOrUpdateArticleFromResponseWithoutRelatedArticle(articleResponse: nl.sharerental.be.infrastructure.seobotai.SingleArticleResponse): BlogArticle {
        val category = findOrCreateCategory(articleResponse.data.article.category)
        val tags = articleResponse.data.article.tags.map { findOrCreateTag(it) }

        val blogArticle = BlogArticle(
            id = articleResponse.data.article.id,
            slug = articleResponse.data.article.slug,
            headline = articleResponse.data.article.headline,
            metaDescription = articleResponse.data.article.metaDescription,
            metaKeywords = articleResponse.data.article.metaKeywords,
            html = articleResponse.data.article.html,
            outline = articleResponse.data.article.outline,
            deleted = articleResponse.data.article.deleted,
            published = articleResponse.data.article.published,
            tags = tags,
            category = category,
            readingTime = articleResponse.data.article.readingTime,
            publishedAt = articleResponse.data.article.publishedAt,
            relatedPosts = emptyList()
        )

        return blogArticle
    }

    /**
     * Converts and saves a full BlogArticle from a SingleArticleResponse.
     */
    fun updateArticleWithRelatedPosts(articleResponse: nl.sharerental.be.infrastructure.seobotai.SingleArticleResponse): BlogArticle {
        val category = findOrCreateCategory(articleResponse.data.article.category)
        val tags = articleResponse.data.article.tags.map { findOrCreateTag(it) }
        val relatedPosts = articleResponse.data.article.relatedPosts.map { findOrCreateArticle(it) }

        val blogArticle = BlogArticle(
            id = articleResponse.data.article.id,
            slug = articleResponse.data.article.slug,
            headline = articleResponse.data.article.headline,
            metaDescription = articleResponse.data.article.metaDescription,
            metaKeywords = articleResponse.data.article.metaKeywords,
            html = articleResponse.data.article.html,
            outline = articleResponse.data.article.outline,
            deleted = articleResponse.data.article.deleted,
            published = articleResponse.data.article.published,
            tags = tags,
            category = category,
            readingTime = articleResponse.data.article.readingTime,
            publishedAt = articleResponse.data.article.publishedAt,
            relatedPosts = relatedPosts
        )

        return blogArticle
    }
}
