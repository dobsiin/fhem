# FHEM Docker

I'm running this container on my Synology DiskStation 1513+. Just for some Home Automation fun :) This docker image contains FHEM and is based on Debian Jessie.

## Run:
```
docker run -d \
		   --net=host \
           -p 8083:8083 \
           -p 51826:51826 \
           dobsiin/fhem
```
