package nl.sharerental.be.user.infrastructure.repository

import nl.sharerental.be.user.User
import org.springframework.data.repository.CrudRepository

interface UserRepository: CrudRepository<User, String>