# Jenkins Swarm Docker container

This container runs the jenkins-swarm client.

## Configuration

### Volumes

The following volumes can be mapped.

#### Workspaces

The volume used by the Jenkins Swarm is exposed as a volume. Use `--volume /tmp/jenkins:/opt/jenkins-workspace` when
running a container.

#### Docker

Docker can be used by jobs that are run by the Swarm container, use `--volume /var/lib/docker.sock:/var/lib/docker.sock`.

Note: The containers will be run on the same host as the Swarm container. This means any volumes mapped will be to the host.
To access the path that should be used for hosting the environment variable `JENKINS_WORKSPACE_DIR` can be used.

### Environment variables

Environment variables can be set that are passed to the jenkins-client. See the
[Jenkins Swarm documentation](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin#SwarmPlugin-AvailableOptions)
for further details.

#### Required
  JENKINS_MASTER_URL: The jenkins master url

#### Optional
  JENKINS_SLAVE_USER: The username to connect to the master
  JENKINS_SLAVE_PASSWORD: The password to connect to the master
  JENKINS_SWARM_MODE: The swarm mode. Defaults to exclusive
  JENKINS_SWARM_EXECUTORS: The number of executors. Defaults to 1
  JENKINS_SWARM_LABELS: The labels to apply to the swarm instance.
  JENKINS_SWARM_NAME: The name of the swarm instance.
  JENKINS_SWARM_DESCRIPTION: The description of the swarm instance