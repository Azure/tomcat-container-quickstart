FROM mcr.microsoft.com/openjdk/jdk:11-ubuntu
ARG APP_FILE=ROOT.war
ARG TOMCAT_VERSION=9.0.38
ARG SERVER_XML=server.xml
ARG LOGGING_PROPERTIES=logging.properties
ARG CATALINA_PROPERTIES=catalina.properties
ARG TOMCAT_MAJOR=9

# As provided here, only the access log gets written to this location.
# Mount to a persistent volume to preserve access logs.
# Modify this value to specify a different log directory.
# e.g. /home/logs in Azure App Service
ENV LOG_ROOT=/tomcat_logs

ENV PATH /usr/local/tomcat/bin:$PATH

# Make Java 8 obey container resource limits, improve performance
ENV JAVA_OPTS "-Djava.awt.headless=true"

# Cleanup & Install
RUN apt-get update -y && \
    apt-get install -y tar unzip wget && \
    wget -O /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz --no-verbose && \
    mkdir /usr/local/tomcat && \ 
    tar xvzf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /usr/local/tomcat --strip-components 1 && \
    rm -f /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    rm -rf /usr/local/tomcat/webapps/*
       
COPY $APP_FILE /usr/local/tomcat/webapps/ROOT.war

RUN mkdir /usr/local/tomcat/webapps/ROOT \
    && cd /usr/local/tomcat/webapps/ROOT \
    && unzip ../ROOT.war \
    && rm -f ../ROOT.war

COPY ${SERVER_XML} /usr/local/tomcat/conf/server.xml
COPY ${LOGGING_PROPERTIES} /usr/local/tomcat/conf/logging.properties
COPY ${CATALINA_PROPERTIES} /usr/local/tomcat/conf/catalina.properties

# Copy the startup script
COPY startup.sh /startup.sh
RUN chmod a+x /startup.sh

EXPOSE 8080

CMD ["/startup.sh"]
