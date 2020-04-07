#! /bin/bash
source ~/.serveret/serveret.conf

echo "  * mods/pg/restart_raw.sh"
~/.asdf/shims/pg_ctl -l ~/pg_log -D ~/.asdf/installs/postgres/$pg_version/data/ restart