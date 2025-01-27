# Stage 1: Build the JAR ( java application runtime ) using maven
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . .

# create JAR File
RUN mvn clean install -DskipTests=true

# Stage 2 : execute JAR File from the above stage
FROM openjdk:17-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/expenseapp.jar

CMD ["java","-jar","expenseapp.jar"]
