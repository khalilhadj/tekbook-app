FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /build
COPY . .
RUN mvn -q -DskipTests package

FROM gcr.io/distroless/java21-debian12
COPY --from=build /build/target/*.jar /app.jar
USER 10001
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
