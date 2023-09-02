package nl.sharerental.be.lessor.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.lessor.LessorEntity
import nl.sharerental.be.lessor.Location
import nl.sharerental.contract.http.LessorApi
import nl.sharerental.contract.http.model.GetLessorResult
import nl.sharerental.contract.http.model.Lessor
import nl.sharerental.contract.http.model.LessorInput
import nl.sharerental.contract.http.model.Pageable
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class LessorController(val lessorRepository: LessorRepository): LessorApi {

    @Transactional
    override fun createLessor(lessorInput: LessorInput?): ResponseEntity<Lessor> {

        requireNotNull(lessorInput) { "LessorInputEmpty" }
        requireNotNull(lessorInput.name) { "LessorNameEmpty" }

        val lessorEntity = LessorEntity(
            name = lessorInput.name,
            description = lessorInput.description,
            primaryLocation = Location(
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
        )

        val result = lessorRepository.save(lessorEntity)

        val response = Lessor()
            .name(result.name)
            .id(result.id)
            .description(result.description)

        return ResponseEntity.ok(response)
    }

    override fun getLessor(pageable: Pageable?): ResponseEntity<GetLessorResult> {
        return super.getLessor(pageable)
    }

    override fun updateLessor(id: Long?, lessorInput: LessorInput?): ResponseEntity<Lessor> {
        return super.updateLessor(id, lessorInput)
    }
}