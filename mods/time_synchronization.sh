# test: timedatectl | grep "Time zone: $timezone"
echo "- time_synchronization"
sudo timedatectl set-timezone $timezone
sudo timedatectl set-ntp on
