# Serveret
Serveret is a script tool to provision Ruby on Rails development/staging/production environments.



## Installation (Ubuntu 16.04.4 x64)
Generate your keys (if you don't have them yet):
```
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub  #  add it to your repo site (Github, etc.)
```

Fix your locale, after it, log out and log in (test with 'locale'):
```
echo -e "LANG=en_US.UTF-8\nLANGUAGE=en_US.UTF-8\nLC_ALL=en_US.UTF-8" | sudo tee /etc/default/locale
```

Add serveret, generate Serveretfile and customize it:
```
GO_HOME=$HOME && [ $USER == 'vagrant' ] && GO_HOME=/vagrant && cd $GO_HOME
git clone https://github.com/is-ma/serveret.git .serveret/  # HHH custom branch: --branch v2.0.0
cp .serveret/settings_template.sh Serveretfile
```

For root accounts (NOT FOR vagrant USER), create an account first:
```
source Serveretfile && source .serveret/create_my_user.sh
su - $my_user  # to login with your new user
```

It's time to make the magic and provision your server:
```
source Serveretfile && source .serveret/provision.sh
```

Configure your project (step by step to catch any conflict on the go):
```
# development:
  git clone $app_repo /vagrant/$app_name/code
  cd /vagrant/$app_name/code

  bundle install --without production

  rails db:create  # recreate your config/database.yml first
  rails db:migrate
  rails db:seed
  rails s  # test it is working on port 3000

# staging/production:
  git clone $app_repo ~/$app_name/code
  cd ~/$app_name/code

  export RAILS_ENV=$rails_env  # staging/production
  bundle install --deployment --without development test
  # add/upload config/database.yml, config/master.key
  rails credentials:show  # test
  rails assets:clobber
  rails assets:precompile
  echo -e '\ncd ~/$app_name/code' >> ~/.bashrc

  rails db:create
  rails db:migrate
  rails db:seed
  rails s  # test it is working on port 3000
```

If you've install Nginx, it's a good idea to configure it with your app:
```
source .serveret/nginx_and_more.sh  # UFW, Nginx, ...
```

Try deploying:
```
source $HOME/serveret/deploy.sh

```

Alias deploy script from your dev machine:
```
# examples
alias app_name_staging='ssh user@host'
alias app_name_staging_deploy=='ssh user@host . /home/user/.serveret/deploy.sh'
```


## Tips
  - add database.yml / secrets.yml / master.key to .gitignore
  - for many servers use names instead of IPs (/etc/hosts)
  - symlink environments: production.rb -> staging.rb



## Support
Please [open an issue](https://github.com/is-ma/serveret/issues/new) for support.



## Contributing
Please contribute using [Github Flow](https://guides.github.com/introduction/flow/). Create a branch, add commits, and [open a pull request](https://github.com/is-ma/serveret/compare/).