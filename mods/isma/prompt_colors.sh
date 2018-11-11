#! /bin/bash
echo "- mods/isma/prompt_colors.sh"
git clone -q https://github.com/is-ma/prompt_colors.git ~/.prompt_colors
echo "" >> ~/.bashrc
echo "### IS-MA: PROMPT COLORS ###" >> ~/.bashrc
echo "source ~/.prompt_colors/git_prompt.sh" >> ~/.bashrc
echo "source ~/.prompt_colors/bash_colors.sh" >> ~/.bashrc
echo "source ~/.prompt_colors/ps1.sh" >> ~/.bashrc
source ~/.bashrc