#!/bin/bash
set -e

if [ ! -f /etc/root_provisioned_at ]
  then
  # Update
  yum update -y

  # You need the epel-release for NodeJS & npm
  yum install -y git firefox java epel-release

  # Install what's needed for Xvfb
  yum -y install Xvfb libXfont Xorg
  yum -y groupinstall "X Window System" "Desktop" "Fonts" "General Purpose Desktop"

  # Lets get node
  yum install -y nodejs npm

  # Install sitesped.io
  npm install -g sitespeed.io

  # Install google-chrome and chromedriver
  cat > /etc/yum.repos.d/google-chrome.repo << EOF
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64/
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
enabled=1
gpgcheck=1
EOF
  
  yum install -y google-chrome-stable
  mkdir -p /usr/lib/node_modules/sitespeed.io/node_modules/alto-saxophone/vendor/
  cd       /usr/lib/node_modules/sitespeed.io/node_modules/alto-saxophone/vendor/
  curl -s http://chromedriver.storage.googleapis.com/2.23/chromedriver_linux64.zip -o chromedriver.zip
  unzip chromedriver.zip
  

  date > /etc/root_provisioned_at
fi
