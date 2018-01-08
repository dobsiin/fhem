# FHEM Docker

I'm running this container on my Synology DiskStation 1512+. This docker image contains FHEM v5.8 and is based on last Debian with few dependencies.

## Run:
```
docker run -d \
	   --net=host \
           -p 8083:8083 \
           -p 51826:51826 \
```
