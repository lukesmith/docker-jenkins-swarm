#!/bin/bash

bash /tmp/set_environment_variables.sh

if [ -n "$GIT_USER_EMAIL" ]; then
  /usr/bin/git config --global user.email "$GIT_USER_EMAIL"
fi

if [ -n "$GIT_USER_NAME" ]; then
  /usr/bin/git config --global user.name "$GIT_USER_NAME"
fi

source /etc/environment

/usr/bin/java -jar /opt/jenkins-swarm/swarm-client.jar \
      -fsroot /opt/jenkins-workspace \
      -master "$JENKINS_MASTER_URL" \
      -mode "$JENKINS_SWARM_MODE" \
      -executors "$JENKINS_SWARM_EXECUTORS" \
      -username "$JENKINS_SLAVE_USER" \
      -password "$JENKINS_SLAVE_PASSWORD" \
      -name "$JENKINS_SWARM_NAME" \
      -labels "$JENKINS_SWARM_LABELS" \
      -description "$JENKINS_SWARM_DESCRIPTION"
