package nl.sharerental.be.search

import nl.sharerental.be.infrastructure.ipapi.IpInfo
import nl.sharerental.be.jooq.generated.enums.RentalItemDisplayStatus
import nl.sharerental.be.jooq.generated.enums.RenterTypeEnum
import nl.sharerental.be.jooq.generated.tables.Lessor.Companion.LESSOR
import nl.sharerental.be.jooq.generated.tables.Location.Companion.LOCATION
import nl.sharerental.be.jooq.generated.tables.RentalItem.Companion.RENTAL_ITEM
import nl.sharerental.be.jooq.generated.tables.records.RentalItemRecord
import nl.sharerental.be.jooq.generated.tables.references.IMAGE
import nl.sharerental.be.jooq.generated.tables.references.RENTAL_ITEM_IMAGE
import nl.sharerental.be.location.LocationService
import nl.sharerental.contract.http.model.FilterOption
import nl.sharerental.contract.http.model.FilterOptionOptionsInner
import nl.sharerental.contract.http.model.RenterType as HttpRenterType
import nl.sharerental.contract.http.model.SearchRequest
import nl.sharerental.contract.http.model.SearchRequestFiltersInner
import nl.sharerental.contract.http.model.SearchRequestFiltersInner.FilterTypeEnum
import nl.sharerental.contract.http.model.SearchResultItem
import org.jooq.*
import org.jooq.impl.DSL.*
import org.slf4j.LoggerFactory
import org.springframework.data.domain.PageRequest
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException
import java.math.BigDecimal
import java.net.URI
import java.time.Instant

@Service
class FilterService(
    private val create: DSLContext,
    private val locationService: LocationService
) {

    fun getFilterOptions(query: String?, searchRequest: SearchRequest?, ip: IpInfo?): List<FilterOption> {
        // time duration in milliseconds
        val start = Instant.now()

        val filterOptions = filterFields.map { tableField ->
            getCountsForDistinctFieldValuesWithFilter(
                query,
                searchRequest,
                tableField,
                ip
            )
        }
            .filter { it.options.isNotEmpty() }

        val end = Instant.now()
        logger.debug("Time taken to get filters: {} ms", end.toEpochMilli() - start.toEpochMilli())

        return filterOptions
    }

    //TODO: caching
    fun getCountsForDistinctFieldValuesWithFilter(
        query: String?,
        searchRequest: SearchRequest?,
        tableField: TableField<RentalItemRecord, out Any>,
        ip: IpInfo?
    ): FilterOption {

        val result = create.select(tableField, count())
            .from(RENTAL_ITEM)
            .join(LESSOR)
            .on(RENTAL_ITEM.OWNER_ID.eq(LESSOR.ID))
            .join(LOCATION)
            .on(LESSOR.PRIMARY_LOCATION.eq(LOCATION.ID))
            .where(buildCompleteFilter(searchRequest, query, ip))
            .and(tableField.isNotNull)
            .groupBy(tableField)
            .fetch()

        return FilterOption()
            .apply {
                this.field = tableField.name
                this.options = result.map {
                    FilterOptionOptionsInner().apply {
                        this.value = it.value1().toString()
                        this.count = it.value2()
                    }
                }
            }
    }

    fun count(query: String?, searchRequest: SearchRequest?, ip: IpInfo?): Int {
        val start = Instant.now()

        val i = create.selectCount()
            .from(RENTAL_ITEM)
            .join(LESSOR)
            .on(RENTAL_ITEM.OWNER_ID.eq(LESSOR.ID))
            .join(LOCATION)
            .on(LESSOR.PRIMARY_LOCATION.eq(LOCATION.ID))
            .where(buildCompleteFilter(searchRequest, query, ip))
            .fetchOne(0, Int::class.java) ?: 0
        val end = Instant.now()
        logger.debug("Time taken to count: {} ms", end.toEpochMilli() - start.toEpochMilli())
        return i
    }

    fun search(
        query: String?,
        pageRequest: PageRequest,
        searchRequest: SearchRequest?,
        ip: IpInfo?
    ): MutableList<SearchResultItem> {
        val start = Instant.now()

        val fetch = create.select(
            RENTAL_ITEM.ID,
            RENTAL_ITEM.NAME,
            RENTAL_ITEM.SLUG,
            RENTAL_ITEM.SHORT_DESCRIPTION,
            RENTAL_ITEM.PRICE_24H,
            LESSOR.NAME,
            LOCATION.CITY,
            select(IMAGE.IMAGE_URL)
                .from(IMAGE)
                .join(RENTAL_ITEM_IMAGE)
                .on(IMAGE.ID.eq(RENTAL_ITEM_IMAGE.IMAGE_ID))
                .where(RENTAL_ITEM_IMAGE.RENTAL_ITEM_ID.eq(RENTAL_ITEM.ID))
                .limit(1)
                .asField<String>()
        )
            .from(RENTAL_ITEM)
            .join(LESSOR)
            .on(RENTAL_ITEM.OWNER_ID.eq(LESSOR.ID))
            .join(LOCATION)
            .on(LESSOR.PRIMARY_LOCATION.eq(LOCATION.ID))

            .where(buildCompleteFilter(searchRequest, query, ip))
            //TODO add proper sort
            .orderBy(RENTAL_ITEM.PRICE_24H.asc())

            .limit(pageRequest.pageSize)
            .offset(pageRequest.offset)

            .fetch {
                SearchResultItem().apply {
                    this.id = it.component1()
                    this.title = it.component2()
                    this.rentalItemSlug = it.component3()
                    this.shortDescription = it.component4()
                    this.pricePerDay = it.value5()
                    this.lessor = it.value6()
                    this.lessorCity = it.value7()
                    this.imageUrl = it.value8()?.let { it1 -> URI(it1) }
                }
            }

        val end = Instant.now()
        logger.debug("Time taken to search: {} ms", end.toEpochMilli() - start.toEpochMilli())
        return fetch
    }

    private fun buildCompleteFilter(searchRequest: SearchRequest?, query: String?, ip: IpInfo?) =
        searchRequestToCondition(searchRequest)
            .and(baseFilterAndQuery(query))
            .and(queryLocationBasedOnSearchOrIp(searchRequest, ip))

    private fun queryLocationBasedOnSearchOrIp(searchRequest: SearchRequest?, ip: IpInfo?): Condition {

        filterByZipCodeIfPresent(searchRequest)?.let {
            logger.debug("Filtering by zip code: {}", searchRequest?.distance?.zipCode ?: "")
            return it }
        filterByLatLongIfPresent(searchRequest)?.let {
            logger.debug("Filtering by lat long: {}, {}", searchRequest?.distance?.latitude ?: "", searchRequest?.distance?.longitude ?: "")
            return it }
        filterByIpIfPresent(ip)?.let {
            logger.debug("Filtering by ip: {}", ip ?: "")
            return it }
        return trueCondition()
    }

    fun filterByIpIfPresent(ip: IpInfo?): Condition? {
        if (ip?.lat != null && ip.lon != null) {
            return condition(
                if_(
                    condition(LOCATION.LONGITUDE.isNotNull).and(LOCATION.LATITUDE.isNotNull),
                    condition("(point(${LOCATION.LONGITUDE.qualifiedName}, ${LOCATION.LATITUDE.qualifiedName}) <@> point(${ip.lon}, ${ip.lat})) < 250"),
                    trueCondition()
                )
            )
        }

        return null
    }

    fun filterByLatLongIfPresent(searchRequest: SearchRequest?): Condition? {
        if (searchRequest?.distance?.latitude != null && searchRequest.distance.longitude != null && searchRequest.distance.radius != null) {
            return condition(
                if_(
                    condition(LOCATION.LONGITUDE.isNotNull).and(LOCATION.LATITUDE.isNotNull),
                    condition("(point(${LOCATION.LONGITUDE.qualifiedName}, ${LOCATION.LATITUDE.qualifiedName}) <@> point(${searchRequest.distance.longitude}, ${searchRequest.distance.latitude})) < ${searchRequest.distance.radius}"),
                    trueCondition()
                )
            )
        }

        return null
    }

    fun filterByZipCodeIfPresent(searchRequest: SearchRequest?): Condition? {
        if (searchRequest?.distance?.zipCode != null && searchRequest.distance.zipCode.isNotEmpty() && searchRequest.distance.radius != null) {

            val locationByPostalCode = locationService.getLocationByPostalCode(
                searchRequest.distance.zipCode
            )

            logger.debug("Location by postal code {}: {}", searchRequest.distance.zipCode, locationByPostalCode)

            if (locationByPostalCode != null) {
                return condition(
                    if_(
                        condition(LOCATION.LONGITUDE.isNotNull).and(LOCATION.LATITUDE.isNotNull),
                        condition("(point(${LOCATION.LONGITUDE.qualifiedName}, ${LOCATION.LATITUDE.qualifiedName}) <@> point(${locationByPostalCode.longitude}, ${locationByPostalCode.latitude})) < ${searchRequest.distance.radius}"),
                        trueCondition()
                    )
                )
            }
        }
        return null
    }

    private fun searchRequestToCondition(searchRequest: SearchRequest?): Condition {

        val renterTypeCondition = if (searchRequest?.renterType != null) {
            val renterType = when (searchRequest.renterType) {
                HttpRenterType.BUSINESS -> RenterTypeEnum.BUSINESS
                HttpRenterType.PRIVATE -> RenterTypeEnum.PRIVATE
            }

            RENTAL_ITEM.RENT_TO_RENTER_TYPE.eq(renterType).or(RENTAL_ITEM.RENT_TO_RENTER_TYPE.isNull)
        } else {
            trueCondition()
        }

        val map = searchRequest?.filters
            ?.map { filter ->
                filterFields.firstOrNull { it.name == filter.field } to filter
            }
            ?.filter { (field, filter) -> field != null && filter != null && filter.values.isNotEmpty() }
            ?.map { (field, filter) ->
                filterToCondition(field, filter)
            }.orEmpty()

        return if (map.isNotEmpty()) map.reduce { acc, condition -> acc.and(condition) }
            .and(renterTypeCondition) else trueCondition().and(renterTypeCondition)
    }

    private fun filterToCondition(
        field: TableField<RentalItemRecord, out Any?>?,
        filter: SearchRequestFiltersInner
    ): Condition {
        return if (filter.filterType.equals(FilterTypeEnum.IN)) {
            return field!!.`in`(filter.values)
        } else if (filter.filterType.equals(FilterTypeEnum.WITHINRANGE)) {
            if (field!!.type == BigDecimal::class.java) {
                val castFilter = field as TableField<RentalItemRecord, BigDecimal?>
                return castFilter.between(filter.values[0].toBigDecimal(), filter.values[1].toBigDecimal())
            } else {
                throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST,
                    "Filter field ${field.name} is not of type BigDecimal, cannot apply filter type WITHINRANGE"
                )
            }
        } else {
            trueCondition()
        }
    }

    private fun baseFilterAndQuery(query: String?) = RENTAL_ITEM.DISPLAY_STATUS.eq(RentalItemDisplayStatus.ACTIVE)
        .and(
            RENTAL_ITEM.NAME.likeIgnoreCase("%$query%")
                .or(RENTAL_ITEM.BRAND.likeIgnoreCase("%$query%"))
                .or(RENTAL_ITEM.SHORT_DESCRIPTION.likeIgnoreCase("%$query%"))
                .or(RENTAL_ITEM.LONG_DESCRIPTION.likeIgnoreCase("%$query%"))
        )

    companion object {
        private val logger = LoggerFactory.getLogger(FilterService::class.java)

        val filterFields = listOf(
            RENTAL_ITEM.PRICE_24H,
            RENTAL_ITEM.BRAND,
            RENTAL_ITEM.CATEGORY,
            RENTAL_ITEM.FUEL_TYPE,
            RENTAL_ITEM.MATERIAL_TYPE,
            RENTAL_ITEM.MAXIMUM_PRESSURE_BARS,
            RENTAL_ITEM.MAXIMUM_HORSE_POWER,
            RENTAL_ITEM.REQUIRED_POWER_VOLTAGE_VOLT,
            RENTAL_ITEM.WORK_WIDTH_METERS,
            RENTAL_ITEM.VACUUM_ATTACHMENT_POSSIBLE,
            RENTAL_ITEM.CAPACITY_LITERS,
            RENTAL_ITEM.ITEM_HEIGHT,
            RENTAL_ITEM.ITEM_WIDTH,
            RENTAL_ITEM.ITEM_LENGTH,
            RENTAL_ITEM.POWER_WATT,
            RENTAL_ITEM.MAXIMUM_SURFACE_SQUARE_METERS,
            RENTAL_ITEM.DELIVERY_POSSIBLE,
            RENTAL_ITEM.DELIVERY_PRICE,
            RENTAL_ITEM.REACH_METERS,
            RENTAL_ITEM.CARRYING_WEIGHT_KILOGRAMS,
            RENTAL_ITEM.MAXIMUM_WORK_HEIGHT_METERS,
            RENTAL_ITEM.INTRINSIC_WEIGHT_KILOGRAMS,
        )
    }
}
