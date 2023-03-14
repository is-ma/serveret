#! /bin/bash
source ~/.serveret/serveret.conf

echo "********** Ubuntu: " && cat /etc/issue && echo "" && echo ""
[ $ISMA_GIT_SHORTCUTS == 'yes' ] && echo "********** Git:" && git --version && echo "" 
[ $TIME_SYNCHRONIZATION == 'yes' ] && echo "********** Date and time: " && date && echo ""
[ $POSTGRESQL == 'yes' ] && echo "********** ASDF: " && asdf --version && echo ""
[ $POSTGRESQL == 'yes' ] && echo "********** Postgres: " && psql --version && echo ""
[ $pg_reload_on_reboot == 'yes' ] && echo "********** Crontab configuration: " && crontab -l && echo ""
[ $pg_allow_remote_access == 'yes' ] && echo "********** Posgres remote access configuration: " && tail -n1 /home/$USER/.asdf/installs/postgres/$pg_version/data/pg_hba.conf && echo ""
[ $POSTGRESQL == 'yes' ] && echo "********** Postgres status: " && source ~/.serveret/mods/pg/status.sh && echo ""
[ $RAILS == 'yes' ] && echo "********** Ruby: " && ruby --version && echo ""
[ $RAILS == 'yes' ] && echo "********** Bunlder: " && bundler --version && echo ""
[ $RAILS == 'yes' ] && echo "********** Node: " && node --version && echo ""
[ $RAILS == 'yes' ] && echo "********** Rails: " && rails --version && echo ""

[ $ACK == 'yes' ] && echo "********** Ack: " && ack --version | head -n1 && echo ""
# [ $VARNISH_CACHE == 'yes' ] && echo "********** X: " && date && echo ""
# [ $UFW == 'yes' ] && echo "********** X: " && date && echo ""
# [ $NGINX_PASSENGER == 'yes' ] && echo "********** X: " && date && echo ""
# [ $INSTALL_RAILS_APP == 'yes' ] && echo "********** X: " && date && echo ""
# [ $USER == 'vagrant' ] && echo "********** X: " && date && echo ""

