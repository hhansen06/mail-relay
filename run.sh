#! /usr/bin/env ash

export MY_DOMAIN=${MY_DOMAIN:-"relay.example.com"}
export MY_NETWORKS=${MY_NETWORKS:-"192.168.0.0/16 172.16.0.0/12 10.0.0.0/8"}

# Templates
j2 /root/conf/main.cf > /etc/postfix/main.cf

# Custom aliases
newaliases
postfix start-fg
