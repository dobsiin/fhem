# FHEM Docker

I'm running this container on my Synology DiskStation 1512+. This docker image contains FHEM and is based on Debian Stretch with curl.

## Run:
```
docker run -d \
	   --net=host \
           -p 8083:8083 \
           -p 51826:51826 \
           dobsiin/fhem
```
