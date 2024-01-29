package nl.sharerental.be.user.infrastructure

import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.contract.http.RenterApi
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException
import nl.sharerental.contract.http.model.Renter as HttpRenter

@RestController
class RenterController(
    private val currentUserService: CurrentUserService,
): RenterApi {

    private val logger = LoggerFactory.getLogger(RenterController::class.java)

    override fun getRenter(): ResponseEntity<HttpRenter> {
        logger.info("Get renter information")
        currentUserService.get().renterInformation?.let {
            return ResponseEntity.ok(it.toResponse())
        } ?: throw ResponseStatusException(HttpStatus.NOT_FOUND)
    }
}