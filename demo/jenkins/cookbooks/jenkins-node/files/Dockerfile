FROM jenkins/jenkins:lts-alpine

USER root

RUN \
	mkdir -p /aws && \
	apk -Uuv add groff less python py-pip && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

RUN apk add apache-ant --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ --allow-untrusted
ENV ANT_HOME /usr/share/java/apache-ant
ENV PATH $PATH:$ANT_HOME/bin

USER jenkins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

COPY security.groovy /home/security.groovy

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
