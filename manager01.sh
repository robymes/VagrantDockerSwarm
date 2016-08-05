#!/usr/bin/env bash

sudo apt-get update
sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant
sudo docker swarm init --advertise-addr 10.0.7.11 --listen-addr 10.0.7.11:2377
sudo docker swarm join-token worker --quiet > /vagrant/tokenworker.txt
sudo docker swarm join-token manager --quiet > /vagrant/tokenmanager.txt
sudo docker node update --availability=drain manager01