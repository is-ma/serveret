echo "***********************************************"
echo "***** C H E C K   V E R S I O N S   N O W *****"
echo "***********************************************"

echo -e "\n***** UBUNTU"; cat /etc/issue

echo -e "\n***** ASDF"; asdf --version
echo -e "\n***** POSTGRE SQL"; psql --version; pg_status
echo -e "\n***** RUBY"; ruby --version
echo -e "\n***** BUNDLER"; bundler --version
echo -e "\n***** NODE"; node --version
echo -e "\n***** RAILS"; rails --version
echo -e "\n***** UFW"; sudo ufw status
echo -e "\n***** VARNISH"; sudo service varnish status | head -n5
echo -e "\n***** NGINX"; sudo service nginx status | head -n5
echo -e "\n***** ACK"; ack --version

echo -e "\n***** CRONTAB"; crontab -l
