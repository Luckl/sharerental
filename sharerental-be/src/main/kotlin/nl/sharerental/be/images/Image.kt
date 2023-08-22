package nl.sharerental.be.images

import jakarta.persistence.*

@Entity
@Table(name = "image")
data class Image(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    val imageUrl: String // You can add other image-related fields here
)