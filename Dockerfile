#FROM openjdk:11-bullseye
FROM openjdk:8-bullseye

LABEL maintainer="ledinhloi1997@gmail.com" version="8.7.1"

ARG ATLASSIAN_PRODUCTION=atlassian-fisheye
ARG APP_NAME=fisheye
ARG APP_VERSION=4.7.0
ARG AGENT_VERSION=1.3.3
ARG MYSQL_DRIVER_VERSION=8.0.22

ENV FISHEYE_HOME=/var/fisheye \
    FISHEYE_INSTALL=/opt/fisheye/fecru-4.7.0 \
    JVM_MINIMUM_MEMORY=1g \
    JVM_MAXIMUM_MEMORY=3g \
    JVM_CODE_CACHE_ARGS='-XX:InitialCodeCacheSize=1g -XX:ReservedCodeCacheSize=2g' \
    AGENT_PATH=/var/agent \
    AGENT_FILENAME=atlassian-agent.jar \
    LIB_PATH=/atlassian-fisheye/WEB-INF/lib
ENV JAVA_OPTS="-javaagent:${AGENT_PATH}/${AGENT_FILENAME} ${JAVA_OPTS}"

#RUN apt-get update && apt-get upgrade -y && apt-get install -y \
#      curl \
#	  unzip

RUN mkdir -p ${FISHEYE_INSTALL} ${FISHEYE_HOME} ${AGENT_PATH} ${FISHEYE_INSTALL}${LIB_PATH} \
&& curl -o ${AGENT_PATH}/${AGENT_FILENAME} https://github.com/haxqer/confluence/releases/download/v${AGENT_VERSION}/atlassian-agent.jar -L \
&& curl -o /tmp/atlassian.zip https://www.atlassian.com/software/fisheye/downloads/binary/${APP_NAME}-${APP_VERSION}.zip -L \
&& unzip -q /tmp/atlassian.zip -d /opt/fisheye/ \
&& rm -f /tmp/atlassian.zip \
&& curl -o ${FISHEYE_INSTALL}/lib/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar -L \
&& cp ${FISHEYE_INSTALL}/lib/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar ${FISHEYE_INSTALL}${LIB_PATH}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar \
&& echo "FISHEYE_INST = ${FISHEYE_HOME}" > /etc/environment \
&& cp ${FISHEYE_INSTALL}/config.xml ${FISHEYE_HOME}/config.xml

WORKDIR $FISHEYE_INSTALL
EXPOSE 8060

ENTRYPOINT ["/opt/fisheye/fecru-4.7.0/bin/start.sh"]
