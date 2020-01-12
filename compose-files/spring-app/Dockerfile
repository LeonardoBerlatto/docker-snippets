# cria build com o alpine do jdk
FROM openjdk:8-jdk-alpine as build

# vai para o diretório
WORKDIR /workspace/app

# copia o necessário pra buildar
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

# instala o necessário

RUN ./mvnw install -DskipTests

RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)


FROM openjdk:8-jdk-alpine

# seta perfil do spring para docker
ENV SPRING_PROFILES_ACTIVE="docker"

VOLUME /tmp

ARG DEPENDENCY=/workspace/app/target/dependency

# copia o que foi gerado no primeiro build

COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

# executa o comando necessário para subir a aplicação

ENTRYPOINT ["java","-cp","app:app/lib/*","com.docker.test.dockerapp.DockerAppApplication"]