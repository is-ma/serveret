IS_MA__SERVERET_PATH=$HOME/.is-ma/serveret

# IS-MA
source $IS_MA__SERVERET_PATH/mods/isma/aliaz.sh
source $IS_MA__SERVERET_PATH/mods/isma/colorful.sh
source $IS_MA__SERVERET_PATH/mods/isma/gitz.sh

# update and sync
source $IS_MA__SERVERET_PATH/mods/update_ubuntu.sh
timezone=America/Regina
source $IS_MA__SERVERET_PATH/mods/time_synchronization.sh

# small tools
source $IS_MA__SERVERET_PATH/mods/ack/ack.sh

# PostgreSQL
asdf_version=0.11.2
pg_version=11.7
source $IS_MA__SERVERET_PATH/mods/asdf.sh
source $IS_MA__SERVERET_PATH/mods/pg.sh
$HOME/.asdf/installs/postgres/$pg_version/bin/pg_ctl -l $HOME/pg_log -D $HOME/.asdf/installs/postgres/$pg_version/data/ start

# Ruby & Rails
ruby_version=2.7.7
source $IS_MA__SERVERET_PATH/mods/ruby/ruby.sh
bundler_version=2.1.4
source $IS_MA__SERVERET_PATH/mods/ruby/bundler.sh
node_version=13.11.0
source $IS_MA__SERVERET_PATH/mods/node/node.sh
rails_version=5.2.8.1
source $IS_MA__SERVERET_PATH/mods/rails.sh

# Varnish Cache
source $IS_MA__SERVERET_PATH/mods/varnish/varnish_6_6_2_1_xenial.sh

# UFW
rules=()
rules+=("allow ssh")      # it's all you need from development
rules+=("allow http")     # development/production
rules+=("allow https")    # development/production
#rules+=("ufw allow 8080") # open a port
#rules+=("allow from 111.111.111.111")  # total privileges
#rules+=("allow from 10.10.10.10 to any port 5432")  # production db
source $IS_MA__SERVERET_PATH/mods/ufw.sh

# NGINX/PASSENGER
source $IS_MA__SERVERET_PATH/mods/nginx_passenger/install_for_xenial.sh

# toy app
#source $IS_MA__SERVERET_PATH/mods/nginx_passenger/config_rails_app.sh

# checklist
echo ""
echo "***** C H E C K   V E R S I O N S   N O W *****"
echo ""
source $IS_MA__SERVERET_PATH/main/check_versions.sh
