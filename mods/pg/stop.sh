#! /bin/bash
source ~/.serveret/serveret.conf

PG_CTL_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/bin/pg_ctl
PG_DATA_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/

$PG_CTL_PATH -D $PG_DATA_PATH -m fast stop > /dev/null
source ~/.serveret/mods/pg/status.sh
