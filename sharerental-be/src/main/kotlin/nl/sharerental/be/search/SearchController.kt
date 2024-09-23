package nl.sharerental.be.search

import com.fasterxml.jackson.databind.ObjectMapper
import nl.sharerental.be.infrastructure.PageableHelper.pageRequest
import nl.sharerental.be.infrastructure.ipapi.IpApiClient
import nl.sharerental.be.infrastructure.slack.SlackClient
import nl.sharerental.be.rentalitem.infrastructure.repository.RentalItemRepository
import nl.sharerental.be.search.infrastructure.SearchRequestQueryRepository
import nl.sharerental.be.user.CurrentUserService
import nl.sharerental.contract.http.SearchApi
import nl.sharerental.contract.http.model.PaginationResponse
import nl.sharerental.contract.http.model.SearchRequest
import nl.sharerental.contract.http.model.SearchResult
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.context.request.RequestContextHolder
import org.springframework.web.context.request.ServletRequestAttributes
import org.springframework.web.server.ResponseStatusException
import java.math.BigDecimal
import java.math.RoundingMode
import java.time.Instant
import nl.sharerental.contract.http.model.RentalItem as HttpRentalItem


@RestController
class SearchController(
    private val rentalItemRepository: RentalItemRepository,
    private val filterService: FilterService,
    private val ipApi: IpApiClient,
    private val searchRequestQueryRepository: SearchRequestQueryRepository,
    private val objectMapper: ObjectMapper,
    private val userService: CurrentUserService,
    private val slackClient: SlackClient
    ) : SearchApi {


    override fun search(
        query: String?,
        page: Int?,
        size: Int?,
        sort: MutableList<String>?,
        searchRequest: SearchRequest?
    ): ResponseEntity<SearchResult> {

        val request = (RequestContextHolder.getRequestAttributes() as ServletRequestAttributes?)?.request

        request?.getHeader("X-Forwarded-For")?.let { logger.debug("Request from IP: $it") }

        searchRequestQueryRepository.save(SearchRequestQuery(
            ipAddress = request?.getHeader("X-Forwarded-For") ?: "",
            userId = userService.getOptional()?.id,
            latitude = searchRequest?.distance?.latitude?.toBigDecimal(),
            longitude = searchRequest?.distance?.longitude?.toBigDecimal(),
            zipCode = searchRequest?.distance?.zipCode,
            country = searchRequest?.distance?.country,
            query = query,
            category = searchRequest?.filters?.findLast { it.field == "category" }?.values.toString(),
            searchRequest = objectMapper.writeValueAsString(searchRequest)
        ))

        val ip = ipApi.getIp(request?.getHeader("X-Forwarded-For") ?: "")

        if (!query.isNullOrBlank()) {
            slackClient.sendSlackMessage("Iemand heeft gezocht naar: $query")
        }

        val start = Instant.now()
        val pageRequest = pageRequest(page, size, sort)

        val filterOptions = filterService.getFilterOptions(query, searchRequest, ip)

        val search = filterService.search(query, pageRequest, searchRequest, ip)

        val count = filterService.count(query, searchRequest, ip)

        val end = Instant.now()
        logger.debug("Total time taken to search: {} ms", end.toEpochMilli() - start.toEpochMilli())

        return ResponseEntity.ok(SearchResult()
            .embedded(search)
            .filterOptions(filterOptions)
            .page(PaginationResponse(
                count.toLong(),
                BigDecimal(count).divide(BigDecimal(pageRequest.pageSize), RoundingMode.UP).toInt(),
                pageRequest.pageNumber)
            ))
    }

    override fun searchDetails(slug: String?): ResponseEntity<HttpRentalItem>? {
        slug ?: throw ResponseStatusException(HttpStatus.BAD_REQUEST)

        return rentalItemRepository.findBySlugAndDisplayStatus(slug)
            .map { it.toResponse() }
            .map { ResponseEntity.ok(it) }
            .orElse(ResponseEntity.notFound().build())
    }

    companion object {
        private val logger = LoggerFactory.getLogger(SearchController::class.java)
    }
}