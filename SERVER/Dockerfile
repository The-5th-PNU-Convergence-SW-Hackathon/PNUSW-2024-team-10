FROM openjdk:17-alpine

WORKDIR /app

COPY ./heron-server.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]