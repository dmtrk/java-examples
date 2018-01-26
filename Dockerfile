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
COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
RUN apk --no-cache add ca-certificates && \
    chmod +x /opt/tini && chown -R 65534 && \
    chmod +x /docker-entrypoint.sh

USER 65534
WORKDIR /opt/
CMD ["/opt/tini","--","/docker-entrypoint.sh"]