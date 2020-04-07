#! /bin/bash
source ~/.serveret/serveret.conf

# test: grep "^port = $pg_port" $PG_CONF_FILE_PATH
echo "  * mods/pg/port.sh"
PG_CONF_FILE_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/postgresql.conf
sed -i "s/#port/port/" $PG_CONF_FILE_PATH
sed -i "s/port = .*/port = $pg_port/" $PG_CONF_FILE_PATH