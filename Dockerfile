FROM debian:jessie

MAINTAINER dominikauer <dobsiin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y --force-yes install wget apt-transport-https libavahi-compat-libdnssd-dev 
RUN apt-get update
RUN apt-get -y --force-yes install git nano make gcc g++ 
# avahi-deamon

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

RUN wget -qO - https://debian.fhem.de/archive.key | apt-key add -
RUN echo "deb https://debian.fhem.de/stable ./" | tee -a /etc/apt/sources.list.d/fhem.list
RUN apt-get update
RUN apt-get -y --force-yes install supervisor fhem telnet
RUN mkdir -p /var/log/supervisor

RUN echo Europe/Berlin > /etc/timezone && dpkg-reconfigure tzdata

# Install Homebridge
RUN wget https://nodejs.org/dist/latest-v0.12.x/node-v0.12.7-linux-x64.tar.gz -P /tmp && cd /usr/local && tar xzvf /tmp/node-v0.12.7-linux-x64.tar.gz --strip=1

RUN ln -s /usr/local/bin/node /usr/bin/node

RUN cd /home && git clone https://github.com/nfarina/homebridge.git && cd homebridge && npm install
RUN npm install -g homebridge-legacy-plugins
RUN npm install -g git+https://github.com/justme-1968/homebridge-fhem.git

# config.json for homebridge
COPY fhem.cfg /opt/fhem/fhem.cfg
COPY config.json /root/.homebridge/config.json
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME ["/opt/fhem"]
EXPOSE 8083
EXPOSE 8082
EXPOSE 51826

CMD ["/usr/bin/supervisord"]