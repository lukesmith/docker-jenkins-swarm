FROM ubuntu:14.04

MAINTAINER Luke Smith

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y openjdk-7-jdk curl make
RUN curl -sSL https://get.docker.com/ubuntu/ | sh
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD /opt/init.sh

VOLUME ["/opt/jenkins-workspace"]

# Default swarm settings
ENV JENKINS_SWARM_EXECUTORS 1
ENV JENKINS_SWARM_MODE exclusive

ADD http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/1.22/swarm-client-1.22-jar-with-dependencies.jar /opt/jenkins-swarm/swarm-client.jar

COPY set_environment_variables.sh /tmp/set_environment_variables.sh
COPY init.sh /opt/init.sh