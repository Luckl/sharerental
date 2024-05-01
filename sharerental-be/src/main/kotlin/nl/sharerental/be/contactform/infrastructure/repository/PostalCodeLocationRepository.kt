package nl.sharerental.be.contactform.infrastructure.repository

import nl.sharerental.be.contactform.PostalCodeId
import nl.sharerental.be.contactform.PostalCodeLocation
import org.springframework.data.jpa.repository.JpaRepository

interface PostalCodeLocationRepository: JpaRepository<PostalCodeLocation, PostalCodeId> {

}