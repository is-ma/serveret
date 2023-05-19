# test: ack --version
echo "- ack"
sudo apt-get install -y ack-grep > /dev/null 2>&1

cat << "EOF" >> ~/.bashrc

### SERVERET: ACK ###
alias ackf='ack --smart-case --type-add=frontend:ext:js,coffee,scss,css,haml,html,yml,md,txt --type=frontend'
alias ackb='ack --smart-case --type-add=backend:ext:gitignore,js,coffee,scss,css,rb,erb,haml,html,yml,md,txt --type=backend --ignore-dir=bin/ --ignore-dir=lib/ --ignore-dir=log/ --ignore-dir=public/assets/ --ignore-dir=tmp/ --ignore-dir=vendor/ --ignore-file=ext:keep,ico,cache,ackrc --ignore-file=is:package.json'
alias ackv="ack 'v\d+\.\d+\.\d+'"
function ackx { ack "$1" -l --print0 | xargs -0 -n1 sed -i '' -e "s+$1+$2+"; }  # ackx v3.0.5 v3.0.6
EOF
