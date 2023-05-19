# test: rails --version | grep $rails_version
echo "- rails v$rails_version"
gem install rails -v $rails_version > /dev/null 2>&1
