# test: sudo service varnish start|stop|reload|restart|status
echo "- varnish v6.6.2.1"

# https://packagecloud.io/varnishcache/varnish66/install#bash
sudo curl -s https://packagecloud.io/install/repositories/varnishcache/varnish66/script.deb.sh | sudo bash > /dev/null 2>&1

# ubuntu/xenial
sudo apt-get install -y varnish=6.6.2-1~xenial > /dev/null 2>&1
sudo service varnish stop

# make a copy && move it to the right place && update path
sudo mv /lib/systemd/system/varnish.service /etc/systemd/system/
sudo cp /etc/systemd/system/varnish.service /etc/systemd/system/varnish.service.bak
sudo systemctl daemon-reload

# aliases
cat << EOF >> ~/.bashrc

### VARNISH CACHE ###
alias v_config='sudo vi /etc/systemd/system/varnish.service'
alias v_edit='sudo vi /etc/varnish/default.vcl'
alias v_start='sudo systemctl daemon-reload && sudo service varnish start'
alias v_stop='sudo systemctl daemon-reload && sudo service varnish stop'
alias v_reload='sudo systemctl daemon-reload && sudo service varnish reload'
alias v_restart='sudo systemctl daemon-reload && sudo service varnish restart'
alias v_status='sudo systemctl daemon-reload && sudo service varnish status'
EOF
