package nl.sharerental.be.transaction

import jakarta.validation.constraints.NotNull
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.transaction.infrastructure.repository.TransactionRepository
import org.springframework.stereotype.Service
import java.time.LocalDate
import java.time.temporal.ChronoUnit

@Service
class TransactionService(
    private val transactionRepository: TransactionRepository,
) {

    fun getAmountOfRentedOutItems(
        rentalItem: RentalItem,
        startDate: @NotNull LocalDate,
        endDate: @NotNull LocalDate
    ): Int {
        val transactions = transactionRepository.findAllByRentalItemAndDateRange(
            rentalItem.id,
            startDate,
            endDate
        ).filter { TransactionStatusEnum.CANCELLED != it.currentStatus?.status }

        return createLocalDateList(startDate, endDate)
            .maxOf { findAmountRentedOnDate(it, transactions) }
    }

    fun findAmountRentedOnDate(date: LocalDate, transactions: List<Transaction>) = transactions
        .filter {
            (it.startDate.isAfter(date) && it.endDate.isBefore(date))
                    || it.startDate.isEqual(date)
                    || it.endDate.isEqual(date)
        }.sumOf { it.amount }

    private fun createLocalDateList(startDate: LocalDate, endDate: LocalDate): List<LocalDate> {
        val dateList = mutableListOf<LocalDate>()
        var currentDate = startDate

        while (!currentDate.isAfter(endDate)) {
            dateList.add(currentDate)
            currentDate = currentDate.plus(1, ChronoUnit.DAYS)
        }

        return dateList
    }
}


