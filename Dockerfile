FROM jenkins
MAINTAINER javier.ramon@gmail.com

USER root


RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update \
    && apt-get install -qq -y make mercurial libnotify-bin locales rpm ruby-sass \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'deb http://ftp.us.debian.org/debian/ sid main contrib non-free' | tee -a /etc/apt/sources.list \
    && echo 'deb-src http://ftp.us.debian.org/debian/ sid main contrib non-free' | tee -a /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -qq -y docker.io \
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
