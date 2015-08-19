# Jenkins Swarm Docker container

This container runs the jenkins-swarm client. It is available on on [Docker Hub](https://registry.hub.docker.com/u/lukesmith/jenkins-swarm/).

The idea for this container is to not actually perform the compilation but instead to run a new Docker container that the build occurs within. The container contains `make`, which makes it super easy to use the container without further modification of build dependencies.

## Configuration

### Volumes

The following volumes can be mapped.

#### Workspaces

The volume used by the Jenkins Swarm is exposed as a volume. Use `--volume /tmp/jenkins:/opt/jenkins-workspace` when
running a container.

#### Docker

Docker can be used by jobs that are run by the Swarm container, use `--volume /var/lib/docker.sock:/var/lib/docker.sock`.

Note: The containers will be run on the same host as the Swarm container. This means any volumes mapped will be to the host.
You can use `$(PWD)` if you use a `Makefile` which will give you the path to the projects absolute path on the host, see below example.

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
    GIT_USER_EMAIL: The git users email
    GIT_USER_NAME: The git users name

## Example

### Makefile

```make
.PHONY : build ci

default: ci

build:
		docker build -t my_company/my_project ./

# Use $(PWD) to get the absolute path of the `Makefile` on the Docker host, 
# which should be in your projects root. In this example /opt/output is a volume
# in the container where test results are output to, which are then accessible to
# collect as artifacts in Jenkins.
ci: build
		docker run --rm -i \
			--volume $(PWD)/tmp:/opt/output \
			my_company/my_project \
			bash /path_to_where_your_dockerfile_copies_files/script/ci.sh
```
