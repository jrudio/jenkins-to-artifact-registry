FROM openjdk:19-jdk-slim
LABEL maintainer=jrudio

ARG JMETER_VERSION=5.4.3

RUN apt-get clean && \
  apt-get update && \
  apt-get -qy install \
  wget \
  telnet \
  iputils-ping \
  unzip \
  google-cloud-sdk

RUN   mkdir /jmeter \
  && cd /jmeter/ \
  && wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
  && tar -xzf apache-jmeter-$JMETER_VERSION.tgz \
  && rm apache-jmeter-$JMETER_VERSION.tgz

ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION

RUN cd ${JMETER_HOME} && wget -q -O /tmp/JMeterPlugins-Standard-1.4.0.zip https://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.4.0.zip && unzip -n /tmp/JMeterPlugins-Standard-1.4.0.zip && rm /tmp/JMeterPlugins-Standard-1.4.0.zip

ENV PATH $JMETER_HOME/bin:$PATH
