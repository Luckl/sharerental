package nl.sharerental.be.search

import nl.sharerental.be.jooq.generated.enums.RentalItemDisplayStatus
import nl.sharerental.be.jooq.generated.enums.RenterTypeEnum
import nl.sharerental.be.jooq.generated.tables.Lessor.Companion.LESSOR
import nl.sharerental.be.jooq.generated.tables.Location.Companion.LOCATION
import nl.sharerental.be.jooq.generated.tables.RentalItem.Companion.RENTAL_ITEM
import nl.sharerental.be.jooq.generated.tables.records.RentalItemRecord
import nl.sharerental.be.jooq.generated.tables.references.IMAGE
import nl.sharerental.be.jooq.generated.tables.references.RENTAL_ITEM_IMAGE
import nl.sharerental.contract.http.model.FilterOption
import nl.sharerental.contract.http.model.FilterOptionOptionsInner
import nl.sharerental.contract.http.model.RenterType as HttpRenterType
import nl.sharerental.contract.http.model.SearchRequest
import nl.sharerental.contract.http.model.SearchResultItem
import org.jooq.Condition
import org.jooq.DSLContext
import org.jooq.TableField
import org.jooq.impl.DSL.*
import org.slf4j.LoggerFactory
import org.springframework.data.domain.PageRequest
import org.springframework.stereotype.Service
import java.net.URI
import java.time.Instant

@Service
class FilterService(
    private val create: DSLContext,
) {

    fun getFilterOptions(query: String?, searchRequest: SearchRequest?): List<FilterOption> {
        // time duration in milliseconds
        val start = Instant.now()

        val filterOptions = filterFields.map { tableField ->
            getCountsForDistinctFieldValuesWithFilter(
                query,
                searchRequest,
                tableField,
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
        tableField: TableField<RentalItemRecord, out Any>
    ): FilterOption {

        val result = create.select(tableField, count())
            .from(RENTAL_ITEM)
            .where(baseFilterAndQuery(query))
            .and(searchRequestToCondition(searchRequest))
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

    fun count(query: String?, searchRequest: SearchRequest?): Int {
        val start = Instant.now()
        val additionalFilters = searchRequestToCondition(searchRequest)

        val i = create.selectCount()
            .from(RENTAL_ITEM)
            .where(baseFilterAndQuery(query))
            .and(additionalFilters)
            .fetchOne(0, Int::class.java) ?: 0
        val end = Instant.now()
        logger.debug("Time taken to count: {} ms", end.toEpochMilli() - start.toEpochMilli())
        return i
    }

    fun search(query: String?, pageRequest: PageRequest, searchRequest: SearchRequest?): MutableList<SearchResultItem> {
        val start = Instant.now()

        val additionalFilters = searchRequestToCondition(searchRequest)

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

            .where(baseFilterAndQuery(query))
            .and(additionalFilters)
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
                filterFields.firstOrNull { it.name == filter.field } to filter.values
            }
            ?.filter { (field, values) -> field != null && values.isNotEmpty() }
            ?.map { (field, values) ->
                field!!.`in`(values)
            }.orEmpty()

        return if (map.isNotEmpty()) map.reduce { acc, condition -> acc.and(condition) }
            .and(renterTypeCondition) else trueCondition().and(renterTypeCondition)
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
