#!/usr/bin/env bash

# dependencies
sudo apt update
sudo apt upgrade -y
sudo apt install -y git gcc

# project
PROJECT_URL=https://github.com/bartol/bartol.dev
PROJECT_PATH=$HOME/bartol.dev
git clone $PROJECT_URL $PROJECT_PATH

# service
SERVICE_NAME=www
SERVICE_PATH=$PROJECT_PATH/deploy/service
sudo ln -sv $SERVICE_PATH /lib/systemd/system/$SERVICE_NAME.service
sudo systemctl start $SERVICE_NAME

# nginx
NGINX_SITE=bartol.dev
NGINX_PATH=$PROJECT_PATH/deploy/nginx
sudo apt install -y nginx
sudo cp -v $NGINX_PATH /etc/nginx/sites-available/$NGINX_SITE
sudo ln -sv /etc/nginx/sites-available/$NGINX_SITE /etc/nginx/sites-enabled/
sudo nginx -s reload

# ssl certificate
DOMAIN=bartol.dev
EMAIL=b@bartol.dev
sudo apt install -y certbot python-certbot-nginx
sudo certbot --nginx -n -m $EMAIL --agree-tos --no-redirect \
	-d $DOMAIN -d www.$DOMAIN

# tools
sudo apt install -y htop goaccess

