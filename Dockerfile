# Multi-stage build for Spring Boot (Java 8)

FROM maven:3.9.6-eclipse-temurin-8 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -B -ntp -q -DskipTests dependency:go-offline

COPY src ./src
RUN mvn -B -ntp -DskipTests package

FROM eclipse-temurin:8-jre
ENV JAVA_OPTS="-XX:MaxRAMPercentage=75 -Djava.security.egd=file:/dev/./urandom"
WORKDIR /opt/app

# Create non-root user
RUN addgroup --system app && adduser --system --ingroup app app

COPY --from=build /app/target/*.jar /opt/app/app.jar

USER app
EXPOSE 8082
ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar /opt/app/app.jar"]

