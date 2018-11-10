#! /bin/bash

#################################################
#                init.sh
#################################################
# Create an account (if you're root) and fix your locale

CUSTOM_USER=yes  # creates a user and copy serveret/ proyect there
my_user=deploy  # creates user (sudo), will have same SSH keys as root
my_pass=password  # won't be used for server access
root_pass=$my_pass  # choose one or same as my_pass; won't be used to login in



#################################################
#                 provision.sh
#################################################
# Installs a bunch of software on Ubuntu, either online (like a Droplet) or a dev machine (vagrant)

ISMA_PROMPT_COLORS=yes  # github: is-ma/prompt_colors
ISMA_GIT_SHORTCUTS=yes  # github: is-ma/git_shortcuts

UBUNTU_UPDATE=yes  # runs: sudo apt-get -y update >/dev/null 2>&1

TIME_SYNCHRONIZATION=yes
timezone=America/Mexico_City  # find out more timezones with: timedatectl list-timezones

POSTGRESQL=yes
asdf_version=0.6.0  # will install almost any version of PostgreSQL
pg_version=11.1
pg_port=5432
pg_reload_on_reboot=yes  # add a cronjob for you
pg_allow_remote_access=yes  # if yes, limit access to pg_port with UFW

RAILS=yes
ruby_version=2.5.1  # will be installed by rbenv
bundler_version=1.17
nvm_version=0.33.11  # will be used to install Node.js
node_version=10.13.0
rails_version=5.2.1



#################################################
#                nginx_and_more.sh
#################################################
# Basically installs Passenger + Nginx and configure it for you (use it online)

UFW=yes
#app01=10.10.10.10
#app02=11.11.11.11
dev_machine_ip=111.111.111.111
rules=()
rules+=("allow ssh")                            # any server
rules+=("allow from $dev_machine_ip")           # staging
#rules+=("allow from $app01 to any port 5432")  # production db
#rules+=("allow from $app02 to any port 5432")  # production db

NGINX_PASSENGER=yes
ubuntu_name=xenial  # xenial | ___

CONFIG_SITE=yes  # /etc/nginx/sites-enabled/$app_name.conf
server_name='_'  # "_" is a catch-all domain name; or choose a specific one
listen=80
passenger_friendly_error_pages=on  # it's ok for staging
passenger_app_env=staging  # config/environments/ENVIRONMENT.rb must exists!
app_name=hour_app
app_repo='https://github.com/is-ma/hour-app.git --branch v1.0.0'
