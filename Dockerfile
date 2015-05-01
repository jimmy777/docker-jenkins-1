FROM jenkins
MAINTAINER javier.ramon@gmail.com

RUN apt-get install mercurial rpm-build

EXPOSE 8080
EXPOSE 50000

USER jenkings

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
