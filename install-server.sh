#!/usr/bin/env bash

## Dependencies installation
sudo apt-get install -y software-properties-common apparmor-utils apt-transport-https avahi-daemon ca-certificates curl dbus jq network-manager socat
sudo apt autoremove -y

## Disabling ModemManager (if exist) for compatibility
sudo systemctl disable ModemManager
sudo systemctl stop ModemManager

## Install Docker CE
sudo curl -fsSL get.docker.com | sudo sh

## Install Supervised Home ASsistant
sudo curl -sL "https://raw.githubusercontent.com/Kanga-Who/home-assistant/master/supervised-installer.sh" | sudo bash -s

## Docker-compose installation as a docker container
sudo curl -L --fail https://raw.githubusercontent.com/linuxserver/docker-docker-compose/master/run.sh -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cd ~
homeDir=$(pwd)
## Creation of the services' dir
if [ ! -d ~/.services ]
then
	mkdir ~/.services
fi
cd ~/.services

## Importing and setting docker-compose.yml
>"${homeDir}/docker-compose.yml" curl -sL "https://raw.githubusercontent.com/Ryther/homeserver/master/docker-compose.yml"
sed -i 's|{homeDir}|'"${homeDir}"'|' "${homeDir}/docker-compose.yml"

read -p "Enter transmission username: "  transmissionUsername
sed -i 's|{transmissionUsername}|'"${transmissionUsername}"'|' "${homeDir}/docker-compose.yml"
read -p "Enter transmission password: "  transmissionPassword
sed -i 's|{transmissionPassword}|'"${transmissionPassword}"'|' "${homeDir}/docker-compose.yml"
