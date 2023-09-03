package nl.sharerental.be.lessor.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.lessor.LessorEntity
import nl.sharerental.be.lessor.Location
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.contract.http.LessorApi
import nl.sharerental.contract.http.model.GetLessorResult
import nl.sharerental.contract.http.model.Lessor
import nl.sharerental.contract.http.model.LessorInput
import nl.sharerental.contract.http.model.PaginationResponse
import org.springframework.beans.support.PagedListHolder.DEFAULT_PAGE_SIZE
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class LessorController(val lessorRepository: LessorRepository, val currentUserService: CurrentUserService) : LessorApi {

    @Transactional
    override fun createLessor(lessorInput: LessorInput?): ResponseEntity<Lessor> {

        requireNotNull(lessorInput) { "LessorInputEmpty" }
        requireNotNull(lessorInput.name) { "LessorNameEmpty" }

        val primaryLocation = Location(
            addressLine1 = lessorInput.addressLine1,
            addressLine2 = lessorInput.addressLine2,
            addressLine3 = lessorInput.addressLine3,
            city = lessorInput.city,
            country = lessorInput.country,
            houseNumber = lessorInput.houseNumber,
            houseNumberAddition = lessorInput.houseNumberAddition,
            postalCode = lessorInput.postalCode,
            street = lessorInput.street,
            geoLocation = null
        )

        val lessorEntity = LessorEntity(
            name = lessorInput.name,
            description = lessorInput.description,
            phoneNumber = lessorInput.phoneNumber,
            primaryLocation = primaryLocation,
            lessorFinancialInformation = null,
            locations = setOf(primaryLocation),
            users = setOf(currentUserService.get())
        )

        val result = lessorRepository.save(lessorEntity)

        val response = Lessor()
            .name(result.name)
            .id(result.id)
            .description(result.description)

        return ResponseEntity.ok(response)
    }

    override fun getLessor(page: Int?, size: Int?, sort: MutableList<String>?): ResponseEntity<GetLessorResult> {

        val sortFields = sort?.map { s ->
            Sort.Order(
                Sort.Direction.fromString(s.split(';')[1]),
                s.split(';')[0]
            )
        }
            .orEmpty()

        val pageRequest = PageRequest.of(page ?: 0, size ?: DEFAULT_PAGE_SIZE, Sort.by(sortFields))

        val lessors = lessorRepository.findAllByUsersContaining(currentUserService.get(), pageRequest)
//        val lessors = lessorRepository.findAll(pageRequest)

        val map = lessors.toList().map {
            val lessor = Lessor()
            lessor.id = it.id
            lessor.name = it.name
            lessor.description = it.description
            lessor.phoneNumber = it.phoneNumber
            lessor

        }

        return ResponseEntity.ok(GetLessorResult(map, PaginationResponse(lessors.totalElements, lessors.totalPages, lessors.number)))
    }

    override fun updateLessor(id: Long?, lessorInput: LessorInput?): ResponseEntity<Lessor> {
        return super.updateLessor(id, lessorInput)
    }
}