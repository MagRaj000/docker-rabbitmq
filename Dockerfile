# Use a Maven image to build the application
#FROM maven:3.8.6-openjdk-17 AS build
FROM maven:3.8.1-openjdk-17 AS build
# Set the working directory
WORKDIR /app
# Copy the pom.xml and project source code
COPY pom.xml .
COPY src ./src
# Build the application
RUN mvn clean package -DskipTests

# Use a lightweight JRE image to run the application
#FROM openjdk:17-jdk-slim
FROM eclipse-temurin:17-jdk-focal
# Set the working directory
WORKDIR /app
# Copy the built jar from the build image
COPY --from=build /app/target/docker-rabbitmq-0.0.1-SNAPSHOT.jar ./app.jar
# Command to run the application
CMD ["java", "-jar", "app.jar"]