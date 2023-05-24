# config
IS_MA__SERVERET_PATH=$HOME/.is-ma/serveret

# update and sync
source $IS_MA__SERVERET_PATH/mods/update_ubuntu.sh
timezone=America/Regina; source $IS_MA__SERVERET_PATH/mods/time_synchronization.sh

# installing...
source $IS_MA__SERVERET_PATH/mods/isma/aliaz.sh
source $IS_MA__SERVERET_PATH/mods/isma/colorful.sh
source $IS_MA__SERVERET_PATH/mods/isma/gitz.sh
asdf_version=0.11.2; source $IS_MA__SERVERET_PATH/mods/asdf.sh
pg_version=11.7; source $IS_MA__SERVERET_PATH/mods/pg.sh
ruby_version=2.7.7; source $IS_MA__SERVERET_PATH/mods/ruby/ruby.sh
bundler_version=2.1.4; source $IS_MA__SERVERET_PATH/mods/ruby/bundler.sh
node_version=13.11.0; source $IS_MA__SERVERET_PATH/mods/node.sh
rails_version=5.2.8.1; source $IS_MA__SERVERET_PATH/mods/rails.sh
source $IS_MA__SERVERET_PATH/mods/ufw.sh
source $IS_MA__SERVERET_PATH/mods/nginx.sh
source $IS_MA__SERVERET_PATH/mods/varnish.sh  # v7.3.0.1 for jammy
source $IS_MA__SERVERET_PATH/mods/ack.sh
#source $IS_MA__SERVERET_PATH/mods/config_toy_app.sh

# checklist
source $IS_MA__SERVERET_PATH/check_versions.sh
