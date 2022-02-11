FROM jetbrains/teamcity-agent:2018.1.2 as source

FROM ubuntu:focal

COPY --from=source /opt /opt
COPY --from=source /data /data
COPY --from=source /usr/lib/jvm/oracle-jdk/jre/ /usr/lib/jvm/oracle-jdk/jre/
COPY --from=source /run-agent.sh /run-services.sh /

ENV DOCKER_BUILDKIT=1 \
    JRE_HOME="/usr/lib/jvm/oracle-jdk/jre" \
    CONFIG_FILE="/data/teamcity_agent/conf/buildAgent.properties" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    GIT_SSH_VARIANT="ssh"

RUN  apt-get update && apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y git ca-certificates curl wget unzip docker.io awscli python-is-python2 openssh-client locales && locale-gen en_US.UTF-8

CMD "/run-services.sh"
