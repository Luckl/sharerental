import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
	id("org.springframework.boot") version "3.2.2"
	id("io.spring.dependency-management") version "1.1.3"
	kotlin("jvm") version "1.9.20"
	kotlin("plugin.spring") version "1.9.20"
	kotlin("plugin.jpa") version "1.9.20"
	kotlin("plugin.noarg") version "1.9.20"
	id("org.openapi.generator") version "7.2.0"
	id("org.graalvm.buildtools.native") version "0.9.28"
}

configurations.all {
	exclude(group="commons-logging", module="commons-logging")
}

tasks.bootBuildImage {
	imageName.set("europe-west4-docker.pkg.dev/sharerental-b66f7/sharerental/sharerental-be:latest")
}

tasks.openApiGenerate {
	inputs.dir("$rootDir/../sharerental-api-contracts")
	generatorName.set("spring")
	inputSpecRootDirectory.set("$rootDir/../sharerental-api-contracts")
	mergedFileName.set("sharerental")
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
	implementation("be.woutschoovaerts:mollie:4.0.0") {
		exclude(group="commons-logging", module = "commons-logging")
	}
	implementation("com.google.cloud:google-cloud-logging-logback:0.130.28-alpha")
	implementation("com.fasterxml.jackson.core:jackson-databind:2.15.3")
	implementation("org.hibernate.validator:hibernate-validator")
	implementation("org.openapitools:jackson-databind-nullable:0.2.6")
	implementation("org.flywaydb:flyway-core")
	implementation("org.springframework.boot:spring-boot-starter-actuator")
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")
	implementation("org.springframework.boot:spring-boot-starter-oauth2-resource-server")
	implementation("org.springframework.boot:spring-boot-starter-security")
	implementation("org.springframework.boot:spring-boot-starter-web")
	implementation("org.springframework.boot:spring-boot-starter-webflux")
	implementation("com.google.cloud:spring-cloud-gcp-starter-storage:4.8.3")
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