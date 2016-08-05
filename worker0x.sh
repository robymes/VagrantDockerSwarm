#!/usr/bin/env bash

sudo apt-get update
sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant
TOKEN=$(< /vagrant/tokenworker.txt)
sudo docker swarm join --token $TOKEN 10.0.7.11:2377