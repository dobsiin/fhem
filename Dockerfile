FROM debian:stretch

MAINTAINER CaptainIgloo <joly.sebastien@gmail.com>

# Install dependencies
RUN apt-get update && apt-get install -y curl
RUN apt-get -y --force-yes install supervisor telnet wget vim git nano make gcc g++ apt-transport-https sudo

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
RUN wget -qO https://debian.fhem.de/archive.key | apt-key add
RUN echo "deb https://debian.fhem.de/nightly ./" > /etc/apt/sources.list.d/fhem.list
RUN apt-get update
RUN apt-get -y --force-yes install fhem
RUN mkdir -p /var/log/supervisor

RUN echo Europe/Paris > /etc/timezone && dpkg-reconfigure tzdata

# supervisord.conf for supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chown fhem /opt/fhem/fhem.cfg

# Ports
EXPOSE 8083

CMD ["/usr/bin/supervisord"]
