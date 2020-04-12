#! /bin/bash
source ~/.serveret/serveret.conf

# test: crontab -l | grep $PG_CTL_PATH
echo "  * mods/pg/cronjob.sh"
PG_CTL_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/bin/pg_ctl
PG_DATA_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/
(crontab -l 2>/dev/null; echo "@reboot $PG_CTL_PATH -l pg_log -D $PG_DATA_PATH start" | crontab -) > /dev/null