FROM jenkins
MAINTAINER javier.ramon@gmail.com

USER root

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update \
    && apt-get install -qq -y make mercurial libnotify-bin locales rpm ruby-sass apt-transport-https \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'deb https://get.docker.com/ubuntu docker main' | tee -a /etc/apt/sources.list \
    && echo 'deb-src http://ftp.us.debian.org/debian/ sid main contrib non-free' | tee -a /etc/apt/sources.list \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
    && apt-get update \
    && apt-get install -qq -y lxc-docker \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8080
EXPOSE 50000

USER jenkins

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  


ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
