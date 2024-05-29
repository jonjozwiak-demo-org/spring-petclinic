FROM maven:3.9.7-eclipse-temurin-17 as maven_builder
ENV HOME=/app
WORKDIR $HOME
COPY ./pom.xml $HOME/pom.xml
RUN mvn dependency:go-offline -B
COPY ./src ./src
RUN mvn clean install
ADD . $HOME

FROM eclipse-temurin:17
ENV HOME=/app
RUN mkdir $HOME
COPY --from=maven_builder $HOME/target/spring-petclinic-3.3.0-SNAPSHOT.jar $HOME
EXPOSE 8080
CMD ["java", "-jar", "/app/spring-petclinic-3.3.0-SNAPSHOT.jar"]
