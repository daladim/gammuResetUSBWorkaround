#!/bin/bash

# This periodically checks gammu log.
# If too many "DEVICENOTEXIST" (or similar-looking) errors are reported, it may mean that UMTSkeeper (or
# whatever third-party tool) generated a "reset" command, that prevents gammu-smsd to recover, until a
# reboot is made.

# Quick workaround: restart the raspi in this case.
# (restarting makes gammu append new lines to the log file, so it will not cause a new reboot
# the next time this script is called)

gammuLog="/var/log/gammu-smsd.log"
myLog="/var/log/perso/mobile-control"
myPhoneNumber="0000000"

nErrors=$(tail -n 12 "$gammuLog" | grep -E "DEVICENOTEXIST|TIMEOUT|DEVICEOPENERROR|DEVICELOCKED|DEVICEWRITEERROR|DEVICEREADERROR" | wc -l)
if [[ $nErrors -ge 4 ]]; then
    gammu-smsd-inject TEXT "$myPhoneNumber" -text "Rebooting because of too many errors"   # may not work, as the connection to the device is lost
	echo "[resetusb-workaround] Rebooting because of too many DEVICENOTEXIST" >> "$myLog"
	sleep 15
	sudo reboot
fi