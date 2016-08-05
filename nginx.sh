#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y nginx
sudo service nginx stop
sudo cp /vagrant/nginx.conf /etc/nginx/sites-available/default
sudo service nginx start