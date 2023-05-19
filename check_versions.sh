echo -e "\n***** ***** ***** ***** *****  UBUNTU  ***** ***** *****"
cat /etc/issue

echo -e "\n***** ***** ***** ***** *****     GIT  ***** ***** *****"
git --version

echo -e "\n***** ***** ***** ***** *****    DATE  ***** ***** *****"
date

echo -e "\n***** ***** ***** ***** *****     ACK  ***** ***** *****"
ack --version

echo -e "\n***** ***** ***** ***** *****    ASDF  ***** ***** *****"
asdf --version

echo -e "\n***** ***** ***** ***** ***** POSTGRE SQL  ***** ***** *****"
psql --version
pg_status

echo -e "\n***** ***** ***** ***** *****    RUBY  ***** ***** *****"
ruby --version

echo -e "\n***** ***** ***** ***** ***** BUNDLER  ***** ***** *****"
bundler --version

echo -e "\n***** ***** ***** ***** *****    NODE  ***** ***** *****"
node --version

echo -e "\n***** ***** ***** ***** *****   RAILS  ***** ***** *****"
rails --version

echo -e "\n***** ***** ***** ***** ***** VARNISH  ***** ***** *****"
sudo service varnish status | head -n5

echo -e "\n***** ***** ***** ***** *****     UFW  ***** ***** *****"
sudo ufw status

echo -e "\n***** ***** ***** ***** *****   NGINX  ***** ***** *****"
sudo service nginx status | head -n5
# sudo /usr/sbin/passenger-memory-stats

echo -e "\n***** ***** ***** ***** ***** CRONTAB  ***** ***** *****"
crontab -l
