#!/bin/sh

template='
{{range $p, $conf := .HostConfig.Binds }}
  {{ $conf }}
{{ end }}'

hostbindings=$(docker inspect --format="${template}" $HOSTNAME)

for binding in ${hostbindings// / } ; do
  myArray=(${binding//:/ })
  if [ "${myArray[1]}" == "/opt/jenkins-workspace" ]; then
    hostpath=${myArray[0]}
    break
  fi
done

echo "Discovered host path $hostpath"
echo "JENKINS_WORKSPACE_DIR=$hostpath" >> /etc/environment

if [ "$JENKINS_SWARM_NAME" == "" ] ; then
  name=$(docker inspect --format="{{ .Name }}" $HOSTNAME)
  # Remove the / from the start of the docker name
  name=${name:1:${#name}}
  echo "JENKINS_SWARM_NAME=$name" >> /etc/environment
fi