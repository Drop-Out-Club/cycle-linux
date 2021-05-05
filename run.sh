#!/usr/bin/env bash

# USAGE:
# $0 ip port

# Must have ADB 1.0.41 and scrcpy installed
adb kill-server
( ssh root@$1 -L 5037:localhost:5037 -R 27183:localhost:27183 -p $2 & echo $! >&3 ) 3>pid | scrcpy
kill $(<pid)
rm pid
