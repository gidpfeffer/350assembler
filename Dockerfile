FROM maven:3.6.0-jdk-10 AS MAVEN_TOOL_CHAIN
COPY pom.xml /tmp/
COPY src /tmp/src/
COPY dat /tmp/dat/
COPY examples /tmp/examples/
WORKDIR /tmp/
RUN apt-get update && \
	apt-get install -y openjfx \
	&& mvn compile
CMD mvn exec:java