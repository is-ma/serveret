#! /bin/bash
# test: sudo service varnish start|stop|reload|restart|status
echo "- mods/varnish/varnish_6_6_2_1_xenial.sh"

# https://packagecloud.io/varnishcache/varnish66/install#bash
sudo curl -s https://packagecloud.io/install/repositories/varnishcache/varnish66/script.deb.sh | sudo bash > /dev/null 2>&1

# ubuntu/xenial
sudo apt-get install -y varnish=6.6.2-1~xenial > /dev/null 2>&1

# make a copy && move it to the right place && update path
sudo mv /lib/systemd/system/varnish.service /etc/systemd/system/
sudo cp /etc/systemd/system/varnish.service /etc/systemd/system/varnish.service.bak
sudo systemctl daemon-reload

# use these aliases every time you change varnish.service || vreload/vrestart/vupdate
cat ~/.serveret/mods/varnish/bashrc_varnish.sh >> ~/.bashrc
source ~/.bashrc

# Now what? 
# - Access the configuration file: /etc/systemd/system/varnish.service
# - Add rules to your default.vcl using $varnish_vcl_filepath and vupdate (alias)
# sudo service varnish stop/start/status/restart
