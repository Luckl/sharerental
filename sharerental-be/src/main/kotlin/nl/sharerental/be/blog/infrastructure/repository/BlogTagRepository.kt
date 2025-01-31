package nl.sharerental.be.blog.infrastructure.repository

import nl.sharerental.be.blog.BlogTag
import org.springframework.data.jpa.repository.JpaRepository

interface BlogTagRepository: JpaRepository<BlogTag, String> {
}