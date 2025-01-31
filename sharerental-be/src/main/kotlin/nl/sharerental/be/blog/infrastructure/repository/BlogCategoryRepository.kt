package nl.sharerental.be.blog.infrastructure.repository

import nl.sharerental.be.blog.BlogCategory
import org.springframework.data.jpa.repository.JpaRepository

interface BlogCategoryRepository: JpaRepository<BlogCategory, String> {
}