package nl.sharerental.be.search

import nl.sharerental.be.jooq.generated.enums.RentalItemDisplayStatus
import nl.sharerental.be.jooq.generated.tables.RentalItem.Companion.RENTAL_ITEM
import nl.sharerental.be.jooq.generated.tables.records.RentalItemRecord
import nl.sharerental.contract.http.model.FilterOption
import nl.sharerental.contract.http.model.FilterOptionOptionsInner
import org.jooq.Condition
import org.jooq.DSLContext
import org.jooq.TableField
import org.jooq.impl.DSL.count
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.time.Instant

@Service
class FilterService(
    private val create: DSLContext,
) {

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

    fun getFilterOptions(query: String?): List<FilterOption> {
        // time duration in milliseconds
        val start = Instant.now()

        val filterOptions = filterFields.map { tableField ->
            getCountsForDistinctFieldValuesWithFilter(
                query,
                RENTAL_ITEM.DISPLAY_STATUS.eq(RentalItemDisplayStatus.ACTIVE),
                tableField
            )
        }

        val end = Instant.now()
        logger.debug("Time taken to get all counts: {} ms", end.toEpochMilli() - start.toEpochMilli())

        return filterOptions
    }

    fun getCountsForDistinctFieldValuesWithFilter(
        query: String?,
        filterCondition: Condition,
        tableField: TableField<RentalItemRecord, out Any>
    ): FilterOption {

        val result = create.select(tableField, count())
            .from(RENTAL_ITEM)
            .where(RENTAL_ITEM.DISPLAY_STATUS.eq(RentalItemDisplayStatus.ACTIVE))
            .and(tableField.isNotNull)
            .and(
                RENTAL_ITEM.NAME.likeIgnoreCase("%$query%")
                    .or(RENTAL_ITEM.BRAND.likeIgnoreCase("%$query%"))
                    .or(RENTAL_ITEM.SHORT_DESCRIPTION.likeIgnoreCase("%$query%"))
                    .or(RENTAL_ITEM.LONG_DESCRIPTION.likeIgnoreCase("%$query%"))
            )
            .and(filterCondition)
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

    companion object {
        private val logger = LoggerFactory.getLogger(FilterService::class.java)
    }
}
