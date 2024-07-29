FROM alpine/git as clone
MAINTAINER stangella<stangella9@gmail.com>
WORKDIR /app
RUN git clone https://github.com/spring-projects/spring-petclinic.git
# stage-two
FROM maven:3.5-jdk-17-alpine as build
WORKDIR /app
COPY --from=clone  /app/spring-petclinic /app
RUN mvn package
# stage-third
FROM tomcat:7-jre7

ADD tomcat-users.xml /usr/local/tomcat/conf
COPY --from=build /app/target/spring-petclinic-3.3.0-SNAPSHOT.jar /usr/local/tomcat/webapps
