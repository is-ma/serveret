#! /bin/bash
this_file=mods/pg/asdf.sh

if grep -q ASDF_INSTALLED $cache_path; then
  echo "OK $this_file"
elif [ -z "$asdf_version" ]; then
  echo "- ERROR $this_file: asdf_version" 
else

  # install ASDF
  echo -n "- $this_file v$asdf_version... "
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v$asdf_version > /dev/null 2>&1
  sudo apt-get install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev > /dev/null 2>&1
  # to make this module idempotent...
  if ! grep -q "### SERVERET: ASDF ###" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "### SERVERET: ASDF ###" >> ~/.bashrc
    echo "source ~/.asdf/asdf.sh" >> ~/.bashrc
    echo "source ~/.asdf/completions/asdf.bash" >> ~/.bashrc
    source ~/.asdf/asdf.sh
    source ~/.asdf/completions/asdf.bash
  fi

  # bookmark (or fail)
  if asdf --version | grep -q $asdf_version; then
    echo ASDF_INSTALLED >> $cache_path
    echo "DONE, CONFIRMED VERSION"
  else
    echo "FAIL"
  fi

fi
