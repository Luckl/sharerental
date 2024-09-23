package nl.sharerental.be.lessor.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.location.PostalCodeId
import nl.sharerental.be.location.infrastructure.repository.PostalCodeLocationRepository
import nl.sharerental.be.lessor.Lessor
import nl.sharerental.be.lessor.Location
import nl.sharerental.be.lessor.UserLessor
import nl.sharerental.be.lessor.UserLessorId
import nl.sharerental.be.lessor.infrastructure.repository.LessorRepository
import nl.sharerental.be.lessor.infrastructure.repository.UserLessorRepository
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.contract.http.LessorApi
import nl.sharerental.contract.http.model.GetLessorResult
import nl.sharerental.contract.http.model.Lessor as HttpLessor
import nl.sharerental.contract.http.model.Location as HttpLocation
import nl.sharerental.contract.http.model.LessorInput
import nl.sharerental.contract.http.model.PaginationResponse
import org.slf4j.LoggerFactory
import org.springframework.beans.support.PagedListHolder.DEFAULT_PAGE_SIZE
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class LessorController(
    private val lessorRepository: LessorRepository,
    private val userLessorRepository: UserLessorRepository,
    private val currentUserService: CurrentUserService,
    private val postalCodeLocationRepository: PostalCodeLocationRepository
) : LessorApi {
    private val logger = LoggerFactory.getLogger(LessorController::class.java)

    @Transactional
    override fun createLessor(lessorInput: LessorInput?): ResponseEntity<HttpLessor> {

        requireNotNull(lessorInput) { "LessorInputEmpty" }
        requireNotNull(lessorInput.name) { "LessorNameEmpty" }

        val postalCodeLocation =
            postalCodeLocationRepository.findById(PostalCodeId(lessorInput.postalCode, lessorInput.houseNumber))
                .orElseThrow { IllegalArgumentException("PostalCodeLocationNotFound") }

        val primaryLocation = Location(
            city = lessorInput.city,
            country = lessorInput.country,
            houseNumber = lessorInput.houseNumber,
            postalCode = lessorInput.postalCode,
            street = lessorInput.street,
            latitude = postalCodeLocation.latitude,
            longitude = postalCodeLocation.longitude,
            addressLine1 = "",
            addressLine2 = "",
            addressLine3 = ""
        )

        val lessor = Lessor(
            name = lessorInput.name,
            description = lessorInput.description,
            phoneNumber = lessorInput.phoneNumber,
            primaryLocation = primaryLocation,
            lessorFinancialInformation = null,
            locations = setOf(primaryLocation),
            userLessors = setOf()
        )

        val result = lessorRepository.save(lessor)

        val userLessor = UserLessor(UserLessorId(currentUserService.get().id, result.id))

        userLessorRepository.save(userLessor)

        val response = HttpLessor()
            .name(result.name)
            .id(result.id)
            .description(result.description)

        logger.debug("Created lessor {}", result.id)

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

        val idsForUserId = lessorRepository.getIdsForUserId(currentUserService.get().id)

        val lessors = lessorRepository.findByIdIn(idsForUserId, pageRequest)

        val map = lessors.toList().map {
            val lessor = HttpLessor()
            lessor.id = it.id
            lessor.name = it.name
            lessor.description = it.description
            lessor.phoneNumber = it.phoneNumber
            lessor.primaryLocation = HttpLocation()
                .id(it.primaryLocation.id)
                .country(it.primaryLocation.country)
                .city(it.primaryLocation.city)
                .street(it.primaryLocation.street)
                .postalCode(it.primaryLocation.postalCode)
                .houseNumber(it.primaryLocation.houseNumber)
            lessor

        }

        return ResponseEntity.ok(GetLessorResult(map, PaginationResponse(lessors.totalElements, lessors.totalPages, lessors.number)))
    }

    override fun updateLessor(id: Long?, lessorInput: LessorInput?): ResponseEntity<HttpLessor> {
        return super.updateLessor(id, lessorInput)
    }
}