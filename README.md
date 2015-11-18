# Docker Container for FHEM and homebridge

I'm running this container on my Synology DiskStation. Just for some Home Automation fun :)

This docker image contains FHEM and homebridge and is based on Debian Jessie.

## Run:
```
docker run -d \
           -p 8083:8083 \
           -p 8082:8082 \
           -p 51826:51826 \
           dobsiin/fhem
```

Currently homebridge won't start with supervisor.

There is a problem with dns:
```
[Error: dns service error: unknown error code]
```
thats due to the fact that avahi-daemon is not started.

## Solution:

/etc/init.d/dbus restart

service avahi-daemon start