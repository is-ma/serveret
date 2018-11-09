#! /bin/bash
this_file=mods/isma/prompt_colors.sh

if [ -d ~/.prompt_colors ]; then
  echo "OK $this_file"
else

  # install Prompt colors
  echo -n "- $this_file... "
  git clone -q https://github.com/is-ma/prompt_colors.git ~/.prompt_colors
  # to make this module idempotent...
  if ! grep -q '### IS-MA: PROMPT_COLORS ###' ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "### IS-MA: PROMPT COLORS ###" >> ~/.bashrc
    echo "source ~/.prompt_colors/git_prompt.sh" >> ~/.bashrc
    echo "source ~/.prompt_colors/bash_colors.sh" >> ~/.bashrc
    echo "source ~/.prompt_colors/ps1.sh" >> ~/.bashrc
    source ~/.bashrc
  fi

  # bookmark (automatic by its folder)
  echo "DONE"

fi
