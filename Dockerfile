FROM debian:jessie

MAINTAINER dominikauer <dobsiin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Install dependencies
RUN apt-get update
RUN apt-get -y --force-yes install wget git nano make gcc g++ apt-transport-https libavahi-compat-libdnssd-dev sudo nodejs etherwake

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
RUN echo "deb https://debian.fhem.de/stable ./" | tee -a /etc/apt/sources.list.d/fhem.list
RUN apt-get update
RUN apt-get -y --force-yes install supervisor fhem telnet
RUN mkdir -p /var/log/supervisor

RUN echo Europe/Vienna > /etc/timezone && dpkg-reconfigure tzdata

# Install Homebridge
RUN wget https://nodejs.org/dist/latest-v0.12.x/node-v0.12.9-linux-x64.tar.gz -P /tmp && cd /usr/local && tar xzvf /tmp/node-v0.12.9-linux-x64.tar.gz --strip=1

RUN ln -s /usr/local/bin/node /usr/bin/node

# Install LGTV2
RUN npm install lgtv2

# Install homebridge -> /usr/local/bin/homebridge
RUN cd /home && npm install -g homebridge
# Install netatmo plugin
RUN npm install -g homebridge-netatmo
# Install fhem plugin
RUN npm install -g git+https://github.com/justme-1968/homebridge-fhem.git

# fhem.cfg for fhem, config.json for homebridge and supervisord.conf for supervisor
COPY fhem.cfg /opt/fhem/fhem.cfg
COPY config.json /root/.homebridge/config.json
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY tvoff.js /node_modules/lgtv2/tvoff.js

RUN chown fhem /opt/fhem/fhem.cfg

VOLUME ["/opt/fhem"]

# Ports
EXPOSE 8083
EXPOSE 51826

COPY start.sh ./
RUN chmod +x ./start.sh
CMD ["./start.sh"]