package nl.sharerental.be.transaction

import jakarta.validation.constraints.NotNull
import nl.sharerental.be.rentalitem.RentalItem
import nl.sharerental.be.transaction.infrastructure.repository.TransactionRepository
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneOffset
import java.time.temporal.ChronoUnit

@Service
class TransactionService(
    private val transactionRepository: TransactionRepository,
) {

    private val logger: Logger = LoggerFactory.getLogger(TransactionService::class.java)

    /**
     * expires transactions with currentStatus INITIALIZED and currentStatus time is older than 30 minutes
     * runs every minute
     */
    @Scheduled(cron = "0 * * * * *")
    fun expireTransactions() {
        val transactions = transactionRepository.findAllByCurrentStatusAndOlderThan(
            TransactionStatusEnum.INITIALIZED,
            LocalDateTime.now().minusMinutes(30).toInstant(
            ZoneOffset.UTC))

        transactions.forEach {
            it.currentStatus = TransactionStatus(status = TransactionStatusEnum.CANCELLED, transaction = it)
            transactionRepository.save(it)
        }

        if (transactions.isNotEmpty()) {
            logger.info("Expired {} transactions with payment status INITIALIZED", transactions.size)
        }
    }

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


