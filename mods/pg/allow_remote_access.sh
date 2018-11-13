#! /bin/bash
# test: grep "^host all $USER 0.0.0.0/0 trust" $HBA_CONF_FILE_PATH
echo "  * mods/pg/allow_remote_access.sh"
PG_CONF_FILE_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/postgresql.conf
HBA_CONF_FILE_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/pg_hba.conf
sed -i "s/#listen_addresses/listen_addresses/" $PG_CONF_FILE_PATH
sed -i "s/listen_addresses = 'localhost'/listen_addresses = '*'/" $PG_CONF_FILE_PATH
echo "host all $USER 0.0.0.0/0 trust" >> $HBA_CONF_FILE_PATH