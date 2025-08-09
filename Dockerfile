FROM maven:3.8.5-openjdk-8-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:8-alpine
ENV PROJECT_HOME=/opt/app
WORKDIR $PROJECT_HOME
COPY --from=build /app/target/spring-boot-mongo-1.0.jar $PROJECT_HOME/spring-boot-mongo.jar
EXPOSE 8080
CMD ["java", "-jar", "./spring-boot-mongo.jar"]
