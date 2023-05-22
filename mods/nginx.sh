# https://gorails.com/deploy/ubuntu/22.04#vps
# test: sudo /usr/sbin/passenger-memory-stats
echo "- nginx/passenger"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 > /dev/null 2>&1
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger $(lsb_release -cs) main > /etc/apt/sources.list.d/passenger.list' > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1
sudo apt-get install -y nginx-extras libnginx-mod-http-passenger > /dev/null 2>&1
if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi

# nginx.conf
sudo sed -i "s/www-data;/$USER;/" /etc/nginx/nginx.conf
sudo sed -i "s@/usr/bin/passenger_free_ruby@$HOME/.asdf/shims/ruby@" /etc/nginx/conf.d/mod-http-passenger.conf

# start
sudo service nginx start

# aliases
cat << EOF >> ~/.bashrc
#
### SERVERET: Nginx ###
alias n_status='sudo service nginx status'
alias n_start='sudo service nginx start'
alias n_stop='sudo service nginx stop'
alias n_restart='sudo service nginx restart'
alias n_reload='sudo service nginx reload'
EOF
