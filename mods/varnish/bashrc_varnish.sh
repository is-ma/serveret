
### SERVERET: VARNISH-CACHE ###
source ~/.serveret/serveret.conf
alias vreload='sudo systemctl daemon-reload && sudo service varnish reload'
alias vrestart='sudo systemctl daemon-reload && sudo service varnish restart'
alias vupdate='sudo cp $varnish_vcl_filepath /etc/varnish/default.vcl'
