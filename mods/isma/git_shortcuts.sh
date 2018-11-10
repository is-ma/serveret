#! /bin/bash
this_file=mods/isma/git_shortcuts.sh

if [ -d ~/.git_shortcuts ]; then
  echo "OK $this_file"
else

  # install Git shortcuts
  echo -n "- $this_file... "
  git clone -q https://github.com/is-ma/git_shortcuts.git ~/.git_shortcuts
  # to make this module idempotent...
  if ! grep -q '### IS-MA: GIT SHORTCUTS ###' ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "### IS-MA: GIT SHORTCUTS ###" >> ~/.bashrc
    echo "source ~/.git_shortcuts/git_shortcuts.sh" >> ~/.bashrc
    source ~/.bashrc
  fi

  # bookmark (automatic by its folder)
  echo "DONE"

fi