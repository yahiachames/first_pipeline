FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install
FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/achat-1.0-SNAPSHOT.jar /app/
EXPOSE 9090
CMD ["java","-jar","achat-1.0-SNAPSHOT.jar"]