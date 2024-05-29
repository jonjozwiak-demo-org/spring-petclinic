FROM maven:3.6.1-jdk-8-alpine as maven_builder
ENV HOME=/app
WORKDIR $HOME
COPY ./pom.xml $HOME/pom.xml
RUN mvn dependency:go-offline -B
COPY ./src ./src
RUN mvn clean install
ADD . $HOME

FROM tomcat:8.5.43-jdk8
ENV HOME=/app
COPY --from=maven_builder $HOME/target/spring-petclinic-3.3.0-SNAPSHOT.jar /usr/local/tomcat/webapps
