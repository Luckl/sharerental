package nl.sharerental.be

import com.google.cloud.storage.Storage
import com.google.cloud.storage.StorageOptions
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.ComponentScan

@SpringBootApplication
@ComponentScan(basePackages = ["nl.sharerental"])
class SharerentalBeApplication {
	@Bean
	fun storage(): Storage = StorageOptions.getDefaultInstance().getService()
}

fun main(args: Array<String>) {
	runApplication<SharerentalBeApplication>(*args)
}

