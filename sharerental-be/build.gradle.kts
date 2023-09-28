import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
	id("org.springframework.boot") version "3.1.2"
	id("io.spring.dependency-management") version "1.1.2"
	kotlin("jvm") version "1.8.22"
	kotlin("plugin.spring") version "1.8.22"
	kotlin("plugin.jpa") version "1.8.22"
	kotlin("plugin.noarg") version "1.9.10"
	id("org.openapi.generator") version "7.0.0"
}

tasks.bootBuildImage {
	imageName.set("europe-west4-docker.pkg.dev/sharerental-b66f7/sharerental/sharerental-be:latest")
}

tasks.openApiGenerate {
	inputs.dir("$rootDir/../sharerental-api-contracts")
	generatorName.set("spring")
	inputSpec.set("$rootDir/../sharerental-api-contracts/merged.yaml")
	mergedFileName.set("sharerental.yaml")
	outputDir.set("$buildDir/generated")
	apiPackage.set("nl.sharerental.contract.http")
	invokerPackage.set("nl.sharerental.contract.http.invoker")
	modelPackage.set("nl.sharerental.contract.http.model")
	configOptions.set(mapOf(
		"annotationLibrary" to "none",
		"documentationProvider" to "none",
		"useTags" to "true",
		"interfaceOnly" to "true",
		"useSwaggerUI" to "false",
		"useJakartaEe" to "true",
		"useBeanValidation" to "false",
	))
}

group = "nl.sharerental.be"
version = "0.0.1-SNAPSHOT"
sourceSets {
	main {
		java {
			srcDir("$buildDir/generated/src/main/java")
			srcDir("$rootDir/src/main/kotlin")
		}
	}
}
java {
	sourceCompatibility = JavaVersion.VERSION_17
}

repositories {
	mavenCentral()
}

dependencies {
	developmentOnly("io.github.kilmajster:ngrok-spring-boot-starter:0.9.0")
	implementation("be.woutschoovaerts:mollie:4.0.0")
	implementation("ch.qos.logback:logback-classic:1.3.5")
	implementation("ch.qos.logback.contrib:logback-json-classic:0.1.5")
	implementation("ch.qos.logback.contrib:logback-jackson:0.1.5")
	implementation("com.fasterxml.jackson.core:jackson-databind:2.12.7.1")
	implementation("org.hibernate.validator:hibernate-validator")
	implementation("org.openapitools:jackson-databind-nullable:0.2.6")
	implementation("org.flywaydb:flyway-core")
	implementation("org.springframework.boot:spring-boot-starter-actuator")
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")
	implementation("org.springframework.boot:spring-boot-starter-oauth2-resource-server")
	implementation("org.springframework.boot:spring-boot-starter-security")
	implementation("org.springframework.boot:spring-boot-starter-web")
	implementation("com.google.cloud:spring-cloud-gcp-starter-storage:4.7.2")
	implementation("com.bucket4j:bucket4j-core:8.4.0")
	implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
	implementation("io.micrometer:micrometer-tracing-bridge-brave")
	implementation("org.jetbrains.kotlin:kotlin-reflect")
	implementation("org.springframework.kafka:spring-kafka")
	runtimeOnly("org.postgresql:postgresql")
	testImplementation("io.zonky.test:embedded-database-spring-test:2.3.0")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
	testImplementation("org.springframework.kafka:spring-kafka-test")
	testImplementation("org.springframework.security:spring-security-test")
}

tasks.withType<KotlinCompile> {
	kotlinOptions {
		freeCompilerArgs += "-Xjsr305=strict"
		jvmTarget = "17"
	}
}

tasks {
	compileKotlin {
		dependsOn("openApiGenerate")
	}
}

tasks.withType<Test> {
	useJUnitPlatform()
}

tasks.bootJar {
	duplicatesStrategy = DuplicatesStrategy.EXCLUDE
}