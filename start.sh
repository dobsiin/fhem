#!/bin/bash
# short workaround script

/etc/init.d/dbus restart
service avahi-daemon start
/usr/bin/supervisord