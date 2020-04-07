#! /bin/bash
source ~/.serveret/serveret.conf

~/.asdf/shims/pg_ctl -m fast stop > /dev/null
source ~/.serveret/mods/pg/status.sh
