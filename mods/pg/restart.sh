#! /bin/bash
source ~/.serveret/serveret.conf

PG_CTL_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/bin/pg_ctl
PG_DATA_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/

$PG_CTL_PATH -l /home/$USER/pg_log -D $PG_DATA_PATH restart
echo "  * mods/pg/restart.sh"
source ~/.serveret/mods/pg/status.sh
