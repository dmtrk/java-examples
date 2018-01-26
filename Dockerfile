# docker build -t ${PWD##*/} .
# 1. compile Java code inside 'builder' container
FROM gradle:4.5-jdk8-alpine as builder
#FROM gradle:4.5-jdk8-alpine as builder
ENV APPNAME=fix-app
COPY src/ /tmp/src/
COPY build.gradle /tmp/
COPY settings.gradle /tmp/
WORKDIR /tmp/
RUN ls -al /tmp/ && gradle clean build

# 2. copy compiled app to final container
#FROM alpine:3.7
FROM openjdk:8u151-jre-alpine3.7
COPY --from=builder /tmp/build/distributions/${APPNAME} /opt/
COPY docker/tini-static /opt/tini
RUN  chmod +x /opt/tini && apk --no-cache add ca-certificates
WORKDIR /opt/
CMD ["/opt/tini","--","/opt/run.sh"]