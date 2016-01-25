#!/usr/bin/env bash

SERVER_ROOT="/srv/www"
PROTOBOX_PASS='_PROTOBOX_PASS'
PROTOBOX_NAME='_PROTOBOX_NAME'
PROTOBOX_ROOT="${SERVER_ROOT}/${PROTOBOX_NAME}"

INSTALLED=test -d "${PROTOBOX_ROOT}"

# Install nginx, php, mysql and git
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y nginx
sudo apt-get install -y php5-cgi php5-common php5-json php5-gd php5-mcrypt php5-memcache php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-fpm
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PROTOBOX_PASS"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PROTOBOX_PASS"
sudo apt-get -y install mysql-server
sudo apt-get install php5-mysql
sudo apt-get -y install git

# Create dirs
sudo mkdir -p "${PROTOBOX_ROOT}"

# Deploy nginx config (=> default)
NGINX_TEMPLATE=/vagrant/_templates/nginx.conf
if [ ! -d /vagrant ]; then
  wget https://bitbucket.org/mblarsen/protobox/raw/master/_templates/nginx.conf /tmp/
  NGINX_TEMPLATE=/tmp/nginx.conf
fi
sud sed "s/_PROTOBOX_NAME/${PROTOBOX_NAME}" "${NGINX_TEMPLATE}" >> /etc/nginx/sites-available/default
service nginx restart

# Install composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Run composer
cd "${PROTOBOX_ROOT}"
if [ $INSTALLED == 0 ]; then
  composer create-project slim/slim-skeleton .
  cp /vagrant/_templates/composer.json .
  composer update
else 
  composer install
fi