package nl.sharerental.be.blog.infrastructure

import nl.sharerental.be.blog.BlogArticle
import nl.sharerental.be.blog.BlogEntityFactory
import nl.sharerental.be.blog.infrastructure.repository.BlogArticleRepository
import nl.sharerental.be.infrastructure.seobotai.SeoBotClient
import nl.sharerental.contract.http.BlogApi
import nl.sharerental.contract.http.model.BlogPost
import nl.sharerental.contract.http.model.FullBlogPost
import org.slf4j.LoggerFactory
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class BlogClient(
    private val seoBotClient: SeoBotClient,
    private val blogArticleRepository: BlogArticleRepository,
    private val blogEntityFactory: BlogEntityFactory
) : BlogApi {
    private val logger = LoggerFactory.getLogger(BlogClient::class.java)


    override fun fetchBlogPosts(): ResponseEntity<Void> {
        val articles = seoBotClient.getArticles()
        logger.info("Received articles status: ${articles?.status}")
        logger.info("Received number of articles: ${articles?.data?.articles?.size}")

        logger.debug("Received articles: ${articles?.data}")

        val map = articles?.data?.articles?.map {
            seoBotClient.getArticleById(it.id)
        }

        val entities = map?.map {
            blogEntityFactory.createOrUpdateArticleFromResponseWithoutRelatedArticle(it!!)
        }

        blogArticleRepository.saveAll(entities!!)

        map.forEach {
            blogArticleRepository.save(blogEntityFactory.updateArticleWithRelatedPosts(it!!))
        }

        return ResponseEntity.ok().build()
    }

    override fun getBlogPosts(): ResponseEntity<MutableList<BlogPost>> {
        fetchBlogPosts()
        val posts =
            blogArticleRepository.findAllByDeletedIsFalseOrderByPublishedDesc().map { BlogArticle.toBlogPost(it) }
                .take(5)
        return ResponseEntity.ok(posts.toMutableList())
    }

    override fun getBlogPost(slug: String?): ResponseEntity<FullBlogPost> {
        val post = blogArticleRepository.findBySlugAndDeletedIsFalse(slug!!)
        return if (post != null) {
            logger.info("Found post with slug: $slug")
            ResponseEntity.ok(BlogArticle.toFullBlogPost(post))
        } else {
            ResponseEntity.notFound().build()
        }
    }
}