package nl.sharerental.be.blog

import jakarta.persistence.*
import nl.sharerental.contract.http.model.BlogPost
import nl.sharerental.contract.http.model.Category
import nl.sharerental.contract.http.model.FullBlogPost
import nl.sharerental.contract.http.model.Tag

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

    @ManyToMany(cascade = [])
    var tags: List<BlogTag>,

    @ManyToOne(cascade = [])
    var category: BlogCategory,
    var readingTime: Int,
    var publishedAt: String,
    @ManyToMany(cascade = [])
    var relatedPosts: List<BlogArticle>
) {
    companion object {

        fun toBlogPost(it: BlogArticle): BlogPost =
            BlogPost()
                .apply {
                    this.id = it.id
                    this.slug = it.slug
                    this.headline = it.headline
                }

        fun toFullBlogPost(post: BlogArticle): FullBlogPost = FullBlogPost()
            .apply {
                this.id = post.id
                this.slug = post.slug
                this.headline = post.headline
                this.metaDescription = post.metaDescription
                this.metaKeywords = post.metaKeywords
                this.html = post.html
                this.outline = post.outline
                this.deleted = post.deleted
                this.published = post.published
                this.tags = post.tags.map {
                    Tag().apply {
                        this.id = it.id
                        this.name = it.title
                    }
                }
                this.category = Category().apply {
                    this.id = post.category.id
                    this.name = post.category.title
                }
                this.readingTime = post.readingTime
                this.publishedAt = post.publishedAt
                this.relatedPosts = post.relatedPosts.map {
                    BlogPost().apply {
                        this.id = it.id
                        this.slug = it.slug
                        this.headline = it.headline
                    }
                }
            }
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
        "1970-01-01T00:00:00Z",
        emptyList()
    )
}