# test: psql --version | grep $pg_version
echo "- postgres $pg_version"
sudo apt-get install -y linux-headers-$(uname -r) build-essential libssl-dev libreadline-dev zlib1g-dev libcurl4-openssl-dev uuid-dev icu-devtools > /dev/null 2>&1
asdf plugin-add postgres > /dev/null 2>&1
echo "postgres $pg_version" > ~/.tool-versions
asdf install > /dev/null 2>&1

# config variables
PG_CTL_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/bin/pg_ctl
PG_DATA_PATH=/home/$USER/.asdf/installs/postgres/$pg_version/data/

# intermediate variables
pg_status=$(echo "$PG_CTL_PATH -l /home/$USER/pg_log -D $PG_DATA_PATH status")
pg_start=$(echo "$PG_CTL_PATH -l /home/$USER/pg_log -D $PG_DATA_PATH start")
pg_stop=$(echo "$PG_CTL_PATH -l /home/$USER/pg_log -D $PG_DATA_PATH stop")
pg_restart=$(echo "$PG_CTL_PATH -l /home/$USER/pg_log -D $PG_DATA_PATH restart")

# aliases
cat << EOF >> ~/.bashrc

POSTGRE SQL ###"
alias pg_status='$pg_status'
alias pg_start='$pg_start'
alias pg_stop='$pg_stop'
alias pg_restart='$pg_restart'
EOF

# crontab
crontab -l | { cat; echo "@reboot $PG_CTL_PATH -l /home/$USER/pg_log -D $PG_DATA_PATH start"; } | crontab - > /dev/null 2>&1
