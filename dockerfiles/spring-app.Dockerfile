# creates build with alpine jdk
FROM openjdk:8-jdk-alpine as build

WORKDIR /workspace/app

# copies the necessary files
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

# install all it needs

RUN ./mvnw install -DskipTests

RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)


FROM openjdk:8-jdk-alpine

# set profile for docker configs
ENV SPRING_PROFILES_ACTIVE="docker"

ARG DEPENDENCY=/workspace/app/target/dependency

# copy what the first build generated 

COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

# command to deploy application | note that one of the args point to your main file 

ENTRYPOINT ["java","-cp","app:app/lib/*","com.docker.test.dockerapp.DockerAppApplication"]