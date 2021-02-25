#!/bin/bash
sudo apt-get update -y
sleep 10
sudo wget https://raw.githubusercontent.com/dokku/dokku/v0.23.5/bootstrap.sh
sleep 10
sudo DOKKU_TAG=v0.23.5 bash bootstrap.sh