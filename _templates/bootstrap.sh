#!/usr/bin/env bash

SERVER_ROOT="/srv/www"
PROTOBOX_PASS='_PROTOBOX_PASS'
PROTOBOX_NAME='_PROTOBOX_NAME'
PROTOBOX_ROOT="${SERVER_ROOT}/${PROTOBOX_NAME}"
PROTOBOX_FRAMEWORK="_PROTOBOX_FRMW"

# Install nginx, php, mysql and git
sudo apt-get -y install language-pack-en-base
sudo add-apt-repository ppa:ondrej/php5-5.6
sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php5-5.6
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y nginx
sudo apt-get install -y php5-cgi php5-common php5-json php5-gd php5-mcrypt php5-memcache php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-fpm
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PROTOBOX_PASS"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PROTOBOX_PASS"
sudo apt-get -y install mysql-server
sudo apt-get -y install php5-mysql
sudo apt-get -y install git

# Create dirs
sudo mkdir -p "${PROTOBOX_ROOT}"

# Deploy nginx config (=> default)
NGINX_TEMPLATE=/vagrant/_templates/nginx.conf
if [ ! -d /vagrant ]; then
  wget https://bitbucket.org/mblarsen/protobox/raw/master/_templates/nginx.conf /tmp/
  NGINX_TEMPLATE=/tmp/nginx.conf
fi
TMP_FILE=`mktemp /tmp/nginx.conf.XXXXXXXXXX`
sudo sed -e "s/_PROTOBOX_DIR/${PROTOBOX_NAME}/" "${NGINX_TEMPLATE}" > $TMP_FILE
sudo mv $TMP_FILE /etc/nginx/sites-available/default
service nginx restart

# Install composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Run composer
if [ -d "${PROTOBOX_ROOT}/public/index.php" ]; then
  composer install
else
  if [ "$PROTOBOX_FRAMEWORK" == "slim" ]; then
    cd "${PROTOBOX_ROOT}"
    composer create-project slim/slim-skeleton .
  elif [ "$PROTOBOX_FRAMEWORK" == "laravel" ]; then
    cd "${SERVER_ROOT}"
    composer create-project laravel/laravel "${PROTOBOX_NAME}" "5.1.*"
  fi
  # cp /vagrant/_templates/composer.json .
  composer update
fi
