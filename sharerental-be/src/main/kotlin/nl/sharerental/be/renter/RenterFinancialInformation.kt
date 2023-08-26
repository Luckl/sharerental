package nl.sharerental.be.renter

import jakarta.persistence.*

@Entity
@Table(name = "renter_financial_information")
data class RenterFinancialInformation(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "renter_id")
    val renterId: Long = 0,
    @Column(name = "chamber_of_commerce")
    val chamberOfCommerce: String?,
    @Column(name = "vat_id")
    val vatId: String?,
    @Column(name = "invoice_email")
    val invoiceEmail: String?,
    val iban: String?
)