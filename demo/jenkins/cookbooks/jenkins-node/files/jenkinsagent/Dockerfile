FROM docker:17.12

LABEL maintainer="Viktor Farcic <viktor@farcic.com>"

ARG version=0.2.0
ARG build_date=unknown
ARG commit_hash=unknown
ARG vcs_url=unknown
ARG vcs_branch=unknown

LABEL org.label-schema.vendor="vfarcic" \
    org.label-schema.name="jenkins-swarm-agent" \
    org.label-schema.description="Jenkins agent based on the Swarm plugin" \
    org.label-schema.usage="/src/README.md" \
    org.label-schema.url="https://github.com/vfarcic/docker-jenkins-slave-dind/blob/master/README.md" \
    org.label-schema.vcs-url=$vcs_url \
    org.label-schema.vcs-branch=$vcs_branch \
    org.label-schema.vcs-ref=$commit_hash \
    org.label-schema.version=$version \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$build_date

ENV SWARM_CLIENT_VERSION="3.10" \
    DOCKER_COMPOSE_VERSION="1.16.1" \
    COMMAND_OPTIONS="" \
    USER_NAME_SECRET="" \
    PASSWORD_SECRET=""

RUN adduser -G root -D jenkins && \
    apk --update --no-cache add openjdk8 apache-ant jq python py-pip git openssh ca-certificates openssl && \
    wget -q https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_CLIENT_VERSION}/swarm-client-${SWARM_CLIENT_VERSION}.jar -P /home/jenkins/ && \
    pip install docker-compose && pip install awscli && \
    apk add --update build-base libxml2-dev libffi-dev && \
    apk add --update curl curl-dev && \
    apk add --update httpie && \
    apk add --update ruby && \
    apk add --update ruby-dev && \
    gem install --no-document --source https://rubygems.org --version 2.1.0 inspec
    
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
