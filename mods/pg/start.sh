#! /bin/bash
# test: source $MY_HOME/serveret/mods/pg/status.sh | grep PID
echo "  * mods/pg/start.sh"
~/.asdf/shims/pg_ctl -l ~/pg_log -D ~/.asdf/installs/postgres/$pg_version/data/ start > /dev/null
