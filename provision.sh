#!/usr/bin/env bash

# GPG key for docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add docker to apt-get
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update

#install any binaries for compiling from source
apt-get install -y build-essential

#install apache utilities
apt-get install -y apache2-utils

#install git-scm
apt-get install -y git

#install utilities
apt-get install -y unzip

apt-get install -y memcached

sudo timedatectl set-timezone America/New_York

#install node
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt-get install -y nodejs

sudo npm install -g create-react-app

sudo apt-get install -y docker-ce

# Setup docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose 

#sudo mv ./docker-compose /usr/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# setup permissions for vagrant to access docker (runs on tcp owned by root)
sudo groupadd docker
sudo gpasswd -a vagrant docker

# Install Heroku command line
sudo snap install --classic heroku

# allow non-root user to invoke a Node server on ports < 1024
#sudo setcap 'cap_net_bind_service=+ep' /usr/bin/node

# Don't need to run npm install locally ... the docker images will do it when the image is built!
#cd /var/www
#sudo npm install