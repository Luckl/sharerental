package nl.sharerental.be.rentalitem

import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.user.CurrentUserService
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Component
import org.springframework.web.client.HttpClientErrorException

@Component
class RentalItemAuthorization(
    private val rentalItemRepository: RentalItemRepository,
    private val currentUserService: CurrentUserService
) {

    fun authorizeById(id: Long?): RentalItem {
        id ?: throw HttpClientErrorException(HttpStatus.BAD_REQUEST)

        val item = rentalItemRepository.findById(id).orElseThrow { HttpClientErrorException(HttpStatus.NOT_FOUND) }

        if (!currentUserService.get().userLessors.map { userLessor -> userLessor.lessor }.contains(item.owner)) {
            throw HttpClientErrorException(HttpStatus.UNAUTHORIZED)
        }

        return item
    }
}