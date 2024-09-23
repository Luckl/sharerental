package nl.sharerental.be.location.infrastructure.repository

import nl.sharerental.be.location.PostalCodeId
import nl.sharerental.be.location.PostalCodeLocation
import org.springframework.data.jpa.repository.JpaRepository

interface PostalCodeLocationRepository: JpaRepository<PostalCodeLocation, PostalCodeId> {

}