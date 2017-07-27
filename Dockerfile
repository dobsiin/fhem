FROM debian:jessie

MAINTAINER dominikauer <dobsiin@gmail.com>

# Install dependencies
RUN apt-get update
RUN apt-get -y --force-yes install wget git nano make gcc g++ apt-transport-https sudo

# Install perl packages
RUN apt-get -y --force-yes install libalgorithm-merge-perl \
libclass-isa-perl \
libcommon-sense-perl \
libdpkg-perl \
liberror-perl \
libfile-copy-recursive-perl \
libfile-fcntllock-perl \
libio-socket-ip-perl \
libjson-perl \
libjson-xs-perl \
libmail-sendmail-perl \
libsocket-perl \
libswitch-perl \
libsys-hostname-long-perl \
libterm-readkey-perl \
libterm-readline-perl-perl

# Install fhem
RUN wget -qO - https://debian.fhem.de/archive.key | apt-key add -
RUN echo "deb https://debian.fhem.de/nightly ./" > /etc/apt/sources.list.d/fhem.list
RUN apt-get update
RUN apt-get -y --force-yes install supervisor fhem telnet
RUN mkdir -p /var/log/supervisor

RUN echo Europe/Vienna > /etc/timezone && dpkg-reconfigure tzdata

# Install fhem plugin
#RUN npm install -g git+https://github.com/justme-1968/homebridge-fhem.git

# fhem.cfg for fhem, config.json for homebridge and supervisord.conf for supervisor
# COPY fhem.cfg /opt/fhem/fhem.cfg
# COPY config.json /root/.homebridge/config.json
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# COPY tvoff.js /node_modules/lgtv2/tvoff.js

RUN chown fhem /opt/fhem/fhem.cfg

VOLUME ["/opt/fhem"]

# Ports
EXPOSE 8083

CMD ["/usr/bin/supervisord"]
