FROM openjdk:8-jdk-alpine

ENV SCALA_VERSION 2.12.6
ENV SCALA_HOME /usr/share/scala

ENV SBT_VERSION 0.13.17

# Install Bash
RUN apk add --no-cache bash

RUN \
apk add --no-cache --virtual=build-dependencies wget ca-certificates && \
cd "/tmp" && \

 # Install Scala
wget "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
tar xzf "scala-${SCALA_VERSION}.tgz" && \
mkdir "${SCALA_HOME}" && \
rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \

# Install SBT
wget "https://piccolo.link/sbt-${SBT_VERSION}.tgz" && \
tar -f "sbt-${SBT_VERSION}.tgz" -x -C /usr/local && \
ln -s /usr/local/sbt/bin/sbt /usr/local/bin/sbt && \
sbt sbtVersion && \

# Clean up
apk del build-dependencies && \
rm -rf /tmp/*

# Bashrc
COPY bashrc.bash ~/.bashrc

# Install Server App

RUN mkdir -p /app-src

COPY app /app-src/app
COPY conf /app-src/conf
COPY project /app-src/project
COPY public /app-src/public
COPY build.sbt /app-src

EXPOSE 9000

WORKDIR /app-src

RUN sbt update

RUN sbt compile

CMD "sleep 10"