# test: sudo ufw status
echo "- ufw"
sudo ufw --force reset > /dev/null 2>&1

# config
sudo ufw allow ssh > /dev/null
sudo ufw allow http > /dev/null
sudo ufw allow https > /dev/null
#sudo ufw allow 8080 > /dev/null                  # open a specific port
#sudo ufw allow from 111.111.111.111 > /dev/null  # total privileges
#sudo ufw allow from 10.10.10.10 to any port 5432 # production db

# start
sudo ufw --force enable > /dev/null
sudo ufw logging off > /dev/null
