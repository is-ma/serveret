# test: bundler --version | grep $bundler_version
echo "- mods/ruby/bundler.sh v$bundler_version"
gem install bundler -v $bundler_version > /dev/null 2>&1
