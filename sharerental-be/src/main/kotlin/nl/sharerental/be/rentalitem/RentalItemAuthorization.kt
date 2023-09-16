package nl.sharerental.be.rentalitem

import nl.sharerental.be.lessor.infrastructure.repository.LessorRepository
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.user.CurrentUserService
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Component
import org.springframework.web.server.ResponseStatusException

@Component
class RentalItemAuthorization(
    private val rentalItemRepository: RentalItemRepository,
    private val currentUserService: CurrentUserService,
    private val lessorRepository: LessorRepository
) {

    fun authorizeById(id: Long?): RentalItem {
        id ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST)

        val item = rentalItemRepository.findById(id).orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }

        lessorRepository.getIdsForUserId(currentUserService.get().id)
        if (!lessorRepository.getIdsForUserId(currentUserService.get().id).contains(item.owner.id)) {
            throw ResponseStatusException(HttpStatus.UNAUTHORIZED)
        }

        return item
    }
}