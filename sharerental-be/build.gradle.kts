import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
	id("org.springframework.boot") version "3.1.2"
	id("io.spring.dependency-management") version "1.1.2"
	kotlin("jvm") version "1.8.22"
	kotlin("plugin.spring") version "1.8.22"
	kotlin("plugin.jpa") version "1.8.22"
	id("org.openapi.generator") version "7.0.0"
}

bootJar {
	// Configure the Docker image name
	docker {
		name = 'europe-west4-docker.pkg.dev/sharerental-b66f7/sharerental/sharerental-be:latest'
	}
}

tasks.openApiGenerate {
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
	implementation("org.hibernate.validator:hibernate-validator")
	implementation("org.openapitools:jackson-databind-nullable:0.2.6")
	implementation("org.flywaydb:flyway-core")
	implementation("org.springframework.boot:spring-boot-starter-actuator")
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")
	implementation("org.springframework.boot:spring-boot-starter-oauth2-resource-server")
	implementation("org.springframework.boot:spring-boot-starter-security")
	implementation("org.springframework.boot:spring-boot-starter-web")
	implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
	implementation("io.micrometer:micrometer-tracing-bridge-brave")
	implementation("org.jetbrains.kotlin:kotlin-reflect")
	implementation("org.springframework.kafka:spring-kafka")
	runtimeOnly("com.h2database:h2")
	runtimeOnly("org.postgresql:postgresql")
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
