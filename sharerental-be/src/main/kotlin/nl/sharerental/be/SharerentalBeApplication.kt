package nl.sharerental.be

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.ComponentScan

@SpringBootApplication
@ComponentScan(basePackages = ["nl.sharerental"])
class SharerentalBeApplication

fun main(args: Array<String>) {
	runApplication<SharerentalBeApplication>(*args)
}
