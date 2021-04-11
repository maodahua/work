FROM jenkins/jenkins:lts
USER root
ENV JAVA_OPTS=" \
-Djenkins.install.runSetupWizard=false"
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY maven /var/maven
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
RUN curl -L https://github.com/docker/compose/releases/download/1.29.0/docker-compose-Linux-x86_64 > docker-compose \
    && chmod +x docker-compose \
    && mv docker-compose /usr/local/bin/