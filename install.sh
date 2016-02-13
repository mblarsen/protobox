#!/usr/bin/env bash

# Get user data
echo "Configuring protobox"
read -e -p "Project name [protobox]:" PROTOBOX_NAME
PROTOBOX_NAME=${PROTOBOX_NAME:-protobox}
read -e -p "Framework slim/laravel [slim]:" PROTOBOX_FRMW
PROTOBOX_FRMW=${PROTOBOX_FRMW:-slim}
read -s -p "Password [badedyr19]:" PROTOBOX_PASS
echo
PROTOBOX_PASS=${PROTOBOX_PASS:-badedyr19}
read -e -p "IP 192.168.xx.xx [80.80]:" PROTOBOX_IP
PROTOBOX_IP=${PROTOBOX_IP:-80.80}
read -e -p "Git repo (optional):" PROTOBOX_GIT

# sed -i implementation since `-i` is not supported on Mac OSX
sedi() {
  TMP_FILE=`mktemp /tmp/$3.XXXXXXXXXX`
  sed -e "s/$1/$2/" $3 > $TMP_FILE
  mv $TMP_FILE $3
}

# Prepares Vagrantfile + bootstrap.sh
if [ ! -f Vagrantfile ]; then
  cp _templates/Vagrantfile Vagrantfile
  cp _templates/bootstrap.sh bootstrap.sh
fi
sedi "_PROTOBOX_IP" "${PROTOBOX_IP}" Vagrantfile
sedi "_PROTOBOX_NAME" "${PROTOBOX_NAME}" Vagrantfile
sedi "_PROTOBOX_NAME" "${PROTOBOX_NAME}" bootstrap.sh
sedi "_PROTOBOX_PASS" "${PROTOBOX_PASS}" bootstrap.sh
sedi "_PROTOBOX_FRMW" "${PROTOBOX_FRMW}" bootstrap.sh

# Update git
git remote rm origin &> /dev/null
if [ ! -z "$PROTOBOX_GIT" ]; then
  git remote add -m master origin "$PROTOBOX_GIT"
  git add Vagrantfile bootstrap.sh
  git rm install.sh
  git rm -r _templates/Vagrantfile
  git rm -r _templates/bootstrap.sh
  git commit -m"Configured vagrant box and removed install files"
  git push -u origin --all
fi

echo "Now run: vagrant up"
