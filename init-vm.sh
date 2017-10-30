#!/bin/bash

# Assume UID is root

# Assume the distribution is ubuntu

apt-get update
apt-get -y upgrade
# basic tools
apt-get install -y fail2ban vim tmux
# basic opSec
service fail2ban start

echo "Installing python and pip in 3 secs... Ctrl-C to stop."
sleep 3
# install python for ss and many other jobs.
apt-get install -y python python-pip virtualenv
# install ss
pip install --upgrade pip
pip install shadowsocks

echo "Installing nodejs and npm in 3 secs... Ctrl-C to stop."
sleep 3
# install nodejs and other deps.
apt-get install nodejs nodejs-legacy npm


