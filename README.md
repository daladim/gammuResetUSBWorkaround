# gammuResetUSBWorkaround

**Note** : This "tool" is deprecated. See https://github.com/gammu/gammu/issues/198 on how to not need it.




Very dirty workaround in case a USB reset causes gammu to lose contact with the USB dongle.
I wrote this awful workaround. It basically polls gammu log file, and reboots the computer if too many errors are detected.

Please note that this will reboot the computer whenever such a problem is encountered. This may cause extra problems (is your firewall persistent? are all you services restarted at startup?), so please double check before using.

**How to install**

* Edit the hardcoded paths
* Change file mode to be executable `chmod u+x resetusb-workaround.sh`
* Add a cronjob to this script with `crontab -e`, then add a line such as `0 8 * * * /path/to/resetusb-workaround.sh # run this script everyday at 8am, which may or may not be not often enough`

**Note** This job must be run by a user that has privileges to reboot the computer, such as root (run `sudo crontab -e` to edit root's crontable). However, running something as root is a dangerous thing to do. In case you still want to do it (temporarily, as this is only a temporary workaround :p), be sure at least to make this script and its directory only root-writable, so that malicious users cannot modify it to let their code being run as root.
