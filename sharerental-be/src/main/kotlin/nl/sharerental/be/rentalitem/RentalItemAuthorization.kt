package nl.sharerental.be.rentalitem

import nl.sharerental.be.infrastructure.exceptions.BadRequest
import nl.sharerental.be.infrastructure.exceptions.NotFound
import nl.sharerental.be.lessor.infrastructure.repository.LessorRepository
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.be.infrastructure.exceptions.UnauthorizedException
import org.springframework.stereotype.Component

@Component
class RentalItemAuthorization(
    private val rentalItemRepository: RentalItemRepository,
    private val currentUserService: CurrentUserService,
    private val lessorRepository: LessorRepository
) {

    fun authorizeById(id: Long?): RentalItem {
        id ?: throw BadRequest()

        val item = rentalItemRepository.findById(id).orElseThrow { NotFound() }

        lessorRepository.getIdsForUserId(currentUserService.get().id)
        if (!lessorRepository.getIdsForUserId(currentUserService.get().id).contains(item.owner.id)) {
            throw UnauthorizedException()
        }

        return item
    }
}