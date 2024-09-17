package nl.sharerental.be.infrastructure.seobotai

import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.WebClient
import reactor.core.publisher.Mono

@Service
class SeoBotClient(
    @Value("\${share-rental.seo-bot.api-host}") private val apiHost: String,
    @Value("\${share-rental.seo-bot.api-key}") private val apiKey: String
    ) {

    private val webClient = WebClient
        .builder()
        .baseUrl(apiHost)
        .build()

    // Fetch articles based on query parameters
    fun getArticles(categoryId: String? = null, tagId: String? = null): ArticleResponse? {
        return webClient.get()
            .uri { uriBuilder ->
                uriBuilder
                    .path("/articles")
                    .queryParam("key", apiKey)
                    .queryParam("page", 0)
                    .queryParam("limit", 100)
                    .also {
                        if (categoryId != null) {
                            it.queryParam("categoryId", categoryId)
                        }
                    }
                    .also {
                        if (tagId != null) {
                            it.queryParam("tagId", tagId)
                        }
                    }
                    .build()
            }
            .retrieve()
            .bodyToMono(ArticleResponse::class.java)
            .block()
    }

    // Fetch a single article by articleId
    fun getArticleById(articleId: String): SingleArticleResponse? {
        val uri = "$apiHost/article"

        return webClient.get()
            .uri { uriBuilder ->
                uriBuilder
                    .path("/article")
                    .queryParam("key", apiKey)
                    .queryParam("articleId", articleId)
                    .build()
            }
            .retrieve()
            .bodyToMono(SingleArticleResponse::class.java)
            .block()
    }
}

data class ArticleResponse(
    val status: String,
    val data: ArticleData
)

data class ArticleData(
    val success: Boolean,
    val total: Int,
    val page: Int,
    val limit: Int,
    val articles: List<Article>
)

data class Article(
    val id: String,
    val slug: String,
    val headline: String,
    val metaDescription: String,
    val tags: List<Tag>,
    val category: Category,
    val readingTime: Int,
    val publishedAt: String,
    val relatedPosts: List<RelatedPost>
)

data class FullArticle(
    val id: String,
    val slug: String,
    val headline: String,
    val metaDescription: String,
    val metaKeywords: String,
    val html: String,
    val outline: String,
    val deleted: Boolean,
    val published: Boolean,
    val tags: List<Tag>,
    val category: Category,
    val readingTime: Int,
    val publishedAt: String,
    val relatedPosts: List<RelatedPost>
)

data class Tag(
    val id: String,
    val title: String,
    val slug: String
)

data class Category(
    val id: String,
    val title: String,
    val slug: String
)

data class RelatedPost(
    val id: String,
    val headline: String,
    val slug: String
)

data class SingleArticleResponse(
    val status: String,
    val data: SingleArticleData
)

data class SingleArticleData(
    val success: Boolean,
    val article: FullArticle
)