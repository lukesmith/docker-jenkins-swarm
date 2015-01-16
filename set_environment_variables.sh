#!/bin/sh

if [ "$JENKINS_SWARM_NAME" == "" ] ; then
  name=$(docker inspect --format="{{ .Name }}" $HOSTNAME)
  # Remove the / from the start of the docker name
  name=${name:1:${#name}}
  echo "JENKINS_SWARM_NAME=$name" >> /etc/environment
fi
