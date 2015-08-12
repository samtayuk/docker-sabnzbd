FROM ubuntu:14.04
MAINTAINER Samuel Taylor "samtaylor.uk@gmail.com"

# Version
ENV SABNZBD_VERSION 0.7.20-0ubuntu1~jcfp1~trusty

# Set API key
ENV API_KEY ef8b8c11cc3a000c9cfd9efd6813b1f3

# To get rid of error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4BB9F05F \
  && echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" | tee -a /etc/apt/sources.list \
  && echo "deb http://ppa.launchpad.net/jcfp/ppa/ubuntu trusty main" | tee -a /etc/apt/sources.list \
  && apt-get update -q \
  && apt-get install -qy sabnzbdplus=$SABNZBD_VERSION sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush par2 python-yenc unzip unrar crudini \
  ; apt-get clean \
  ; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/config", "/data/downloads"]

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod u+x  /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/sabnzbdplus", "--config-file", "/config" ,"--server", ":8080"]
