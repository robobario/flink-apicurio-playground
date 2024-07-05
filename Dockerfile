FROM maven:3.9.8-eclipse-temurin-11
COPY pom.xml /code/pom.xml
COPY src /code/src
RUN cd /code && mvn clean install
CMD ["java", "-cp", "/code/target/apicurio-registry-examples-simple-avro-2.6.0.Final.jar", "io.apicurio.registry.examples.simple.avro.SimpleAvroExample"]
