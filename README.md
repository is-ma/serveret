FOR SERVERET README

- it's a IT automation tool for servers running primarily Ruby on Rails
- deploy production and staging servers reliably and efficiently
- allows to scale your application fast
- you can duplicate production servers without creating snowflake servers
- run it once or multiple times, it is idempotent

# NOTES
 # - apps will live in $HOME (but /vagrant in development)
 # - Rails SECRET_KEY_BASE is set on project (cp and .gitignore)
 # - Rails database.yml is set on project (cp and .gitignore)

# TIPS
 # - for many servers use names instead of IPs (/etc/hosts)


HOW TO:

SSH KEYGEN
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub  #  add it to your repo site (Github, etc.)

SERVERET
git clone https://github.com/is-ma/serveret.git --branch v1.0.0 ~/serveret
cd ~/serveret

ROOT_PART
# customize settings.sh
source $SERVERET_PATH/mods/create_my_user.sh

PROVISION

# CONFIGURE YOUR VARIABLES FROM THE PROJECT ITSELF!!
- set your environment from Nginx conf file (passenger_app_env staging;)
- upload your config/database.yml, config/secrets.yml or config/master.key
- ln -s config/environments/production.rb config/environments/staging.rb

