# Docker Container for FHEM

I'm running this container on my Synology DiskStation. Just for some Home Automation fun :)

This docker image contains FHEM and is based on Debian Jessie.

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
