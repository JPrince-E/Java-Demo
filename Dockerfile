#
# Build stage
#
FROM maven:3.8.2-jdk-11 AS build
COPY . .
RUN mvn clean package -Pprod -DskipTests

#
# Package stage
#
FROM openjdk:11-jdk-slim
COPY --from=build /target/theodore-0.0.1-SNAPSHOT.jar theodore.jar
# ENV PORT=8082
EXPOSE 8082
ENTRYPOINT ["java","-jar","theodore.jar"]

## Use the official OpenJDK 11 image as the base image
#FROM adoptopenjdk/openjdk11:alpine-jre
#
## Set the working directory inside the container
#WORKDIR /theodore
#
## Copy the Spring Boot executable JAR file into the container
#COPY target/theodore-0.0.1-SNAPSHOT.jar /theodore
#
## Expose the port that the Spring Boot application listens on
#EXPOSE 8082
#
## Run the Spring Boot application when the container starts
#CMD ["java", "-jar", "theodore-0.0.1-SNAPSHOT.jar"]
