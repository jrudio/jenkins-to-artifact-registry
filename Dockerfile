FROM openjdk:19-jdk-slim
LABEL maintainer=jrudio

ARG JMETER_VERSION=5.4.3

RUN apt-get clean && \
  apt-get update && \
  apt-get -qy install \
  wget \
  curl \
  telnet \
  iputils-ping \
  unzip \
  apt-transport-https ca-certificates gnupg

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -


RUN apt-get update && apt-get install google-cloud-cli

RUN   mkdir /jmeter \
  && cd /jmeter/ \
  && wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
  && tar -xzf apache-jmeter-$JMETER_VERSION.tgz \
  && rm apache-jmeter-$JMETER_VERSION.tgz

ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION

RUN cd ${JMETER_HOME} && wget -q -O /tmp/JMeterPlugins-Standard-1.4.0.zip https://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.4.0.zip && unzip -n /tmp/JMeterPlugins-Standard-1.4.0.zip && rm /tmp/JMeterPlugins-Standard-1.4.0.zip

ENV PATH $JMETER_HOME/bin:$PATH
