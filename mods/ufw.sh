# test: sudo ufw status
echo "- mods/ufw.sh"
sudo ufw --force reset > /dev/null
for (( i=0; i < ${#rules[@]}; i++ )) do
  sudo ufw ${rules[i]} > /dev/null
done
sudo ufw --force enable > /dev/null
sudo ufw logging off > /dev/null
