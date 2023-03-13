#! /bin/bash
source ~/.serveret/serveret.conf

PG_CTL_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/bin/pg_ctl
PG_DATA_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/
PG_STATUS=$($PG_CTL_PATH status -D $PG_DATA_PATH | grep pg_ctl)

echo "  * PosgtreSQL status... $PG_STATUS"
