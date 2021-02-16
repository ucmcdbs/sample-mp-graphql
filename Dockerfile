# build
FROM adoptopenjdk/openjdk11:alpine as builder

WORKDIR /build
ADD . /build/

RUN /build/mvnw -DfinalName=app clean package

# package
FROM openliberty/open-liberty:kernel-java8-openj9-ubi

ARG VERSION=1.0
ARG REVISION=SNAPSHOT

COPY --from=builder /build/server.xml /config/
COPY --from=builder /build/target/app.war /config/apps/
