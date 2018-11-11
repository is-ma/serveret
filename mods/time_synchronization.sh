#! /bin/bash
# test: timedatectl | grep "Time zone: $timezone"
echo "- mods/time_synchronization.sh"
sudo timedatectl set-timezone $timezone
sudo timedatectl set-ntp on