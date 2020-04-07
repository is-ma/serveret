#! /bin/bash
source ~/.serveret/serveret.conf

PG_STATUS=$(~/.asdf/shims/pg_ctl status | grep pg_ctl)
echo "  * PosgtreSQL status... $PG_STATUS"