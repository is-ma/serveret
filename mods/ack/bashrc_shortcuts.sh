
# Ack aliases and functions for searching and replacing versions, frontend and ruby/rails
alias ackf='ack --smart-case --type-add=frontend:ext:js,coffee,scss,css,haml,html,yml,md,txt --type=frontend'
alias ackr='ack --smart-case --type-add=rubyrails:ext:gitignore,js,coffee,scss,css,rb,erb,haml,html,yml,md,txt --type=rubyrails --ignore-dir=bin/ --ignore-dir=lib/ --ignore-dir=log/ --ignore-dir=public/assets/ --ignore-dir=tmp/ --ignore-dir=vendor/ --ignore-file=ext:keep,ico,cache,ackrc --ignore-file=is:package.json'
alias ackv="ack 'v\d+\.\d+\.\d+'"
function ackx { ack "$1" -l --print0 | xargs -0 -n1 sed -i '' -e "s+$1+$2+"; }  # search and replace: ackx v3.0.5 v3.0.6