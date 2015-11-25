# Docker Container for FHEM and homebridge

I'm running this container on my Synology DiskStation. Just for some Home Automation fun :)
The plugins netatmo and fhem are installed.

This docker image contains FHEM and homebridge and is based on Debian Jessie.

## Run:
```
docker run -d \
		   --net=host \
           -p 8083:8083 \
           -p 51826:51826 \
           dobsiin/fhem
```

If you would like to run this Image on a Synology NAS you have to SSH into your NAS and
use the parameter ```--net=host``` otherwise homebridge won't be visible from your homekit app.

Currently homebridge won't start with supervisor.

There is a problem with dns:
```
[Error: dns service error: unknown error code]
```
thats due to the fact that avahi-daemon is not started.

## Solution:

 - Fix avahi-daemon (use 'service avahi-daemon status' to see if it's running):
	/etc/init.d/dbus restart
	apt-get install --reinstall avahi-daemon
	service avahi-daemon start

 - Remember that to restart avahi-daemon you can use 'service avahi-daemon restart', this may solve some dns issues. 

Currently trying to solve this problem..