FROM jenkins
MAINTAINER javier.ramon@gmail.com

USER root

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update \
    && apt-get install -qq -y mercurial rpm-build \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8080
EXPOSE 50000

USER jenkings

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
