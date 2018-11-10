# Serveret
- it's an automation tool for servers running primarily Ruby on Rails
- deploy production and staging servers reliably and efficiently
- allows to scale your application fast
- you can duplicate production servers without creating snowflake servers
- run it once or multiple times, it is idempotent


## What does it (very fast)
- it creates your deployment_user
  * with your given password
  * and add it to sudo group (no more passwords!)
  * add a new password for root
  * copy your SSH credentials to your deployment_user
  * copy Serveret repo to your deployment_user
  * avoids login from root; only from deployment_user (and no password)
- it install the software and versions you choose
  * prompt colors for your bash
  * git shorcuts if you like them
  * fix your locale in Ubuntu
  * updates Ubuntu system
  * synchronize your time with your country preferences
  * installs PostgreSQL, any version
    - and installs a cronjob to guarantee its available on reboots
    - and let you pick the port
    - and let you connect from remote locations
  * installs Ruby, any version (with rbenv)
  * installs Bundler, any version
  * installs Node, any version (with nvm)
  * installs Rails, any version
- it guides you to set up your Rails app with comments after each script
- it provides a firewall (with UFW)
- it installs Passenger + Nginx (and configure it to match your project)
- it let you deploy without using Capistrano (easier, faster)


## Installation (tested on Ubuntu 16.04.4 x64)
* IMPORTANT: v1.0.1 only works online, but not in Vagrant (dev machine)

Generate your keys (if you don't have them yet):
```
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub  #  add it to your repo site (Github, etc.)
```

Add serveret:
```
cd # if you're root (e.g. online Droplet)
cd /vagrant  # if you're on Vagrant dev machine

git clone https://github.com/is-ma/serveret.git --branch v1.0.1 serveret/
cd serveret/
```

Customize settings inside each main script (username, passwords, repo urls, software versions, ...).

Run it:
* if you're root (online), start with ```source root_init.sh```
* if you're in Vagrant (dev machine), start with ```source provision.sh```
* follow the given tips after launching each script

About database and secrets:
  - Rails database.yml info is read from your project (add it to .gitignore)
  - Rails secrets.yml info is read from your project (add it to .gitignore)
  - upload your config/database.yml, config/secrets.yml or config/master.key

Tips:
 - for many servers use names instead of IPs (/etc/hosts)
 - symlink environments: production.rb -> staging.rb


## Support

Please [open an issue](https://github.com/is-ma/serveret/issues/new) for support.


## Contributing

Please contribute using [Github Flow](https://guides.github.com/introduction/flow/). Create a branch, add commits, and [open a pull request](https://github.com/is-ma/serveret/compare/).
