FROM ubuntu:latest


#update et install cur, zip, unzip
RUN apt-get update && apt-get install -y curl zip unzip

# instal sdkman
RUN curl -s "https://get.sdkman.io" | bash

#add sdkman to path
ENV SDKMAN_DIR /root/.sdkman
ENV PATH="${PATH}:${SDKMAN_DIR}/bin"

#install JAVA home
RUN bash -c "source ${SDKMAN_DIR}/bin/sdkman-init.sh && sdk install java 17.0.8-tem"

# add java au path
ENV JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"
ENV PATH="${PATH}:${JAVA_HOME}/bin"

#verif de l'installation de java
RUN java -version

#instal gradle
RUN bash -c "source ${SDKMAN_DIR}/bin/sdkman-init.sh && sdk install gradle"

#add gradle au path
ENV GRADLE_HOME="${SDKMAN_DIR}/candidates/gradle/current"
ENV PATH="${PATH}:${GRADLE_HOME}/bin"

#install spring boot cli
RUN bash -c "source ${SDKMAN_DIR}/bin/sdkman-init.sh && sdk install springboot"

#add spring boot au path
ENV SPRING_BOOT_HOME="${SDKMAN_DIR}/candidates/springboot/current"
ENV PATH="${PATH}:${SPRING_BOOT_HOME}/bin"

RUN spring --version

WORKDIR /app

RUN spring init --dependencies=web,data-jpa,thymeleaf,mariadb,devtools,webflux ./

EXPOSE 8181 35729