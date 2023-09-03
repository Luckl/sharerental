package nl.sharerental.be.lessor

import jakarta.persistence.*

@Entity
@Table(name = "lessor_financial_information")
class LessorFinancialInformation(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "lessor_id")
    val lessorId: Long = 0,
    @Column(name = "chamber_of_commerce")
    val chamberOfCommerce: String?,
    @Column(name = "vat_id")
    val vatId: String?,
    @Column(name = "invoice_email")
    val invoiceEmail: String?,
    val iban: String?,

    @MapsId
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "lessor_id")
    var lessorEntity: LessorEntity
)