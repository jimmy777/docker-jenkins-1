FROM jenkins
MAINTAINER javier.ramon@gmail.com

USER root

RUN 'deb http://http.debian.net/debian jessie-backports main' | tee /etc/apt/sources.list.d/backports.list

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update \
    && apt-get install -qq -y make mercurial libnotify-bin locales rpm ruby-sass \
    && apt-get -t jessie-backports install -qq -y docker.io \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

EXPOSE 8080
EXPOSE 50000

USER jenkins

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
