#!/bin/bash
# short workaround script

export TERM=xterm
/etc/init.d/dbus restart
service avahi-daemon start