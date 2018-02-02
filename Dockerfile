# We're using chrome-driver 2.35 which supports Chrome v62-64
FROM yukinying/chrome-headless-browser-selenium:64.0.3282.24

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV ANT_VERSION 1.9.6
ENV ANT_HOME $HOME/ant
ENV PATH ${PATH}:${ANT_HOME}/bin

# TODO: This is probably a bad idea, but necessary due to parent image https://github.com/yukinying/chrome-headless-browser-docker/blob/master/chromedriver/Dockerfile#L7
USER root

# creates a script to find and set JAVA_HOME
# stolen from openjdk docker : https://github.com/docker-library/openjdk/blob/e3386b5a2b4004da498e145cf840561d50acd7fb/7-jdk/Dockerfile
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/bin/docker-java-home \
	&& chmod +x /usr/bin/docker-java-home

# install openJDK 8
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		openjdk-8-jdk \
	&& rm -rf /var/lib/apt/lists/* \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]

# download and install ant
RUN wget -q http://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz \
  && tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz \
  && mv apache-ant-${ANT_VERSION} ${ANT_HOME} \
  && rm apache-ant-${ANT_VERSION}-bin.tar.gz

WORKDIR /autotest

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
