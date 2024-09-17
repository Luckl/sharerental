package nl.sharerental.be.blog.infrastructure.repository

import nl.sharerental.be.blog.BlogArticle
import org.springframework.data.jpa.repository.JpaRepository

interface BlogArticleRepository: JpaRepository<BlogArticle, String> {

}