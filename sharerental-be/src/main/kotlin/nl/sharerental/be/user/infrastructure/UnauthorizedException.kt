package nl.sharerental.be.user.infrastructure

import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.ResponseStatus

@ResponseStatus(code = HttpStatus.UNAUTHORIZED, reason = "NotAllowed")
class UnauthorizedException : Throwable() {

}
