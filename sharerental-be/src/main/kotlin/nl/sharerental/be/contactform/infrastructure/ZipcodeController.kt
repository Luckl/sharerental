package nl.sharerental.be.contactform.infrastructure

import nl.sharerental.be.contactform.LocationService
import nl.sharerental.contract.http.ZipcodeApi
import nl.sharerental.contract.http.model.GetAddressByZipcode200Response
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class ZipcodeController(
    private val locationService: LocationService,
): ZipcodeApi {
    override fun getAddressByZipcode(
        zipcode: String?,
        houseNumber: String?
    ): ResponseEntity<GetAddressByZipcode200Response> {
        return locationService.getLocation(zipcode!!, houseNumber!!)
            .let { ResponseEntity.ok(it) }
    }
}