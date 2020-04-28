#! /bin/bash
# test: sudo service varnish start|stop|reload|restart|status
echo "- mods/varnish/varnish_64_xenial.sh"

# https://packagecloud.io/varnishcache/varnish64/install#bash
curl -s https://packagecloud.io/install/repositories/varnishcache/varnish64/script.deb.sh | sudo bash > /dev/null 2>&1

# ubuntu/xenial
sudo apt-get install -y varnish=6.4.0-1~xenial > /dev/null 2>&1

sudo service varnish stop

# make a copy && move it to the right place && update path
sudo cp /lib/systemd/system/varnish.service /lib/systemd/system/varnish.service.bak
sudo mv /lib/systemd/system/varnish.service /etc/systemd/system/
sudo systemctl daemon-reload

# use them every time you change varnish.service || /etc/varnish/default.vcl
cat ~/.serveret/mods/varnish/bashrc_shortcuts.sh >> ~/.bashrc
source ~/.bashrc

# Now what? 
# - Access the configuration file: /etc/systemd/system/varnish.service
# - Add rules to your default.vcl using $varnish_vcl path and vupdate (alias)