# test: sudo service varnish start|stop|reload|restart|status
echo "- mods/varnish/varnish_6_6_2_1_xenial.sh"

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
echo "" >> ~/.bashrc
echo "### VARNISH CACHE ###" >> ~/.bashrc
echo "alias v_config='sudo vi /etc/systemd/system/varnish.service'" >> ~/.bashrc
echo "alias v_edit='sudo vi /etc/varnish/default.vcl'" >> ~/.bashrc 
echo "alias v_start='sudo systemctl daemon-reload && sudo service varnish start'" >> ~/.bashrc
echo "alias v_stop='sudo systemctl daemon-reload && sudo service varnish stop'" >> ~/.bashrc
echo "alias v_reload='sudo systemctl daemon-reload && sudo service varnish reload'" >> ~/.bashrc
echo "alias v_restart='sudo systemctl daemon-reload && sudo service varnish restart'" >> ~/.bashrc
echo "alias v_status='sudo systemctl daemon-reload && sudo service varnish status'" >> ~/.bashrc
