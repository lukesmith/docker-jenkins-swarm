FROM ubuntu:14.04

MAINTAINER Luke Smith

RUN apt-get update
RUN apt-get install -y apt-transport-https openjdk-7-jdk curl make openssh-client

RUN echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list \
  && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
  && apt-get update \
  && apt-get install -y lxc-docker-1.7.0

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD /opt/init.sh

VOLUME ["/opt/jenkins-workspace"]

# Default swarm settings
ENV JENKINS_SWARM_EXECUTORS 1
ENV JENKINS_SWARM_MODE exclusive

ADD http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/1.22/swarm-client-1.22-jar-with-dependencies.jar /opt/jenkins-swarm/swarm-client.jar

COPY set_environment_variables.sh /tmp/set_environment_variables.sh
COPY init.sh /opt/init.sh
