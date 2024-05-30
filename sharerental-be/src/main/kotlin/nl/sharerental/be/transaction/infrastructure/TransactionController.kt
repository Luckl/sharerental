package nl.sharerental.be.transaction.infrastructure

import jakarta.transaction.Transactional
import nl.sharerental.be.infrastructure.PageableHelper
import nl.sharerental.be.lessor.Location
import nl.sharerental.be.lessor.infrastructure.repository.LessorRepository
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.transaction.TransactionService
import nl.sharerental.be.transaction.TransactionStatusEnum
import nl.sharerental.be.transaction.infrastructure.repository.TransactionRepository
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.be.user.Renter
import nl.sharerental.be.user.RenterType
import nl.sharerental.be.user.User
import nl.sharerental.contract.http.TransactionApi
import nl.sharerental.contract.http.model.*
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException
import kotlin.math.max
import nl.sharerental.contract.http.model.TransactionStatus as HttpTransactionStatus

@RestController
class TransactionController(
    private val rentalItemRepository: RentalItemRepository,
    private val currentUserService: CurrentUserService,
    private val transactionRepository: TransactionRepository,
    private val transactionService: TransactionService,
    private val lessorRepository: LessorRepository,
) : TransactionApi {

    private val logger: Logger = LoggerFactory.getLogger(TransactionController::class.java)

    override fun calculatePrice(transactionCalculationInput: TransactionCalculationInput?): ResponseEntity<TransactionCalculationResult> {
        transactionCalculationInput ?: ResponseStatusException(HttpStatus.BAD_REQUEST)

        return transactionService.calculatePrice(transactionCalculationInput!!)
            .map { ResponseEntity.ok(TransactionCalculationResult(it)) }
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }
    }

    @Transactional
    override fun mollieCallback(id: String?): ResponseEntity<Void> {
        logger.info("Received mollie webhook call for mollie payment reference {}", id)

        id ?: ResponseStatusException(HttpStatus.BAD_REQUEST)

        transactionService.processMollieCallback(id!!)

        return ResponseEntity.ok().build()
    }

    override fun getTransactions(
        @RequestParam(defaultValue = "0", required = false, value = "page") page: Int?,
        @RequestParam(defaultValue = "8", required = false, value = "size") size: Int?,
        @RequestParam(required = false, value = "sort") sort: MutableList<String>?,
        @RequestParam(required = false, value = "filter") filter: String?,
        @RequestParam(
            required = false,
            value = "status"
        ) status: MutableList<nl.sharerental.contract.http.model.TransactionStatus>?
    ): ResponseEntity<GetTransactionsResult>? {
        val lessors = lessorRepository.getIdsForUserId(currentUserService.get().id)

        if (lessors.size != 1) {
            logger.warn("User {} has {} lessors, cannot retrieve transactions because we dont know for which lessor", currentUserService.get().id, lessors.size)
            throw ResponseStatusException(HttpStatus.NOT_FOUND)
        }

        val actualSort = if (sort?.isEmpty() == true) mutableListOf("startDate;desc") else sort

        status?.map { it.toEntityEnum() } ?: listOf(TransactionStatusEnum.ACCEPTED, TransactionStatusEnum.PAID, TransactionStatusEnum.COMPLETED)

        // Should maybe be in service instead, but it'll just be a pass through to the repository.
        val findAll = transactionRepository.findByLessorIdAndSearch(
            lessors[0],
            filter,
            status?.map { it.toEntityEnum() }.orEmpty(),
            PageableHelper.pageRequest(page, size, actualSort)
        )

        val getTransactionsResult = GetTransactionsResult(
            findAll.content.map { it.toResponse() },
            PaginationResponse(findAll.totalElements, findAll.totalPages, findAll.number)
        )

        return ResponseEntity.ok(getTransactionsResult)
    }

    override fun getAmountAvailableForDate(getAmountAvailableRequest: GetAmountAvailableRequest?): ResponseEntity<GetAmountAvailableResponse> {
        val rentalItem = rentalItemRepository.findById(getAmountAvailableRequest!!.rentalItemId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }

        val amountRentedOut = transactionService.getAmountOfRentedOutItems(
            rentalItem,
            getAmountAvailableRequest.startDate,
            getAmountAvailableRequest.endDate
        )

        return ResponseEntity.ok(GetAmountAvailableResponse(max(rentalItem.amount - amountRentedOut, 0)))
    }

    @Transactional
    override fun startTransaction(createTransactionRequest: CreateTransactionRequest?): ResponseEntity<CreateTransactionResponse> {
        val rentalItem = rentalItemRepository.findById(createTransactionRequest!!.rentalItemId)
            .orElseThrow { ResponseStatusException(HttpStatus.NOT_FOUND) }

        val mollieTransactionCheckoutUrl = transactionService.startTransaction(
            rentalItem,
            createTransactionRequest.startDate,
            createTransactionRequest.endDate,
            createTransactionRequest.amount,
            createTransactionRequest.renter?.toRenter(currentUserService.getOptional())
        )

        return ResponseEntity.ok(CreateTransactionResponse().redirectUrl(mollieTransactionCheckoutUrl))
    }
}

private fun HttpTransactionStatus.toEntityEnum(): TransactionStatusEnum {
    return when(this) {
        HttpTransactionStatus.INITIALIZED -> TransactionStatusEnum.INITIALIZED
        HttpTransactionStatus.PAID -> TransactionStatusEnum.PAID
        HttpTransactionStatus.ACCEPTED -> TransactionStatusEnum.ACCEPTED
        HttpTransactionStatus.COMPLETED -> TransactionStatusEnum.COMPLETED
        HttpTransactionStatus.PAID_OUT -> TransactionStatusEnum.PAID_OUT
        HttpTransactionStatus.CANCELLED -> TransactionStatusEnum.CANCELLED
    }
}

private fun RenterInput.toRenter(user: User?): Renter = Renter(
    firstName = firstName,
    lastName = lastName,
    phoneNumber = phoneNumber,
    email = email,
    location = Location(
        street = street,
        houseNumber = houseNumber,
        postalCode = postalCode,
        city = city,
        country = country,
        addressLine1 = addressLine1,
        addressLine2 = addressLine2,
        addressLine3 = addressLine3,
        geoLocation = null
    ),
    renterType = RenterType.valueOf(renterType.value),
    chamberOfCommerce = chamberOfCommerce,
    vatNumber = vatNumber,
    companyName = companyName,
    createdByUser = user
)