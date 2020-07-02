#!/usr/bin/env bash

sudo -i

## Dependencies installation
apt-get install -y software-properties-common apparmor-utils apt-transport-https avahi-daemon ca-certificates curl dbus jq network-manager socat

## Disabling ModemManager (if exist) for compatibility
systemctl disable ModemManager
systemctl stop ModemManager

## Install Docker CE
curl -fsSL get.docker.com | sh

## Install Supervised Home ASsistant
curl -sL "https://raw.githubusercontent.com/Kanga-Who/home-assistant/master/supervised-installer.sh" | bash -s
exit

## Docker-compose installation as a docker container
sudo curl -L --fail https://raw.githubusercontent.com/linuxserver/docker-docker-compose/master/run.sh -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cd ~
homeDir=$(pwd)
## Creation of the services' dir
mkdir ~/.services && cd ~/.services

## Importing and setting docker-compose.yml
>"${homeDir}/docker-compose.yml" curl -sL "https://raw.githubusercontent.com/Ryther/homeserver/master/docker-compose.yml"
sed -i 's|{homeDir}|'"${homeDir}"'|' "${homeDir}/docker-compose.yml"

read -p "Enter transmission username: "  transmissionUsername
sed -i 's|{transmissionUsername}|'"${transmissionUsername}"'|' "${homeDir}/docker-compose.yml"
read -p "Enter transmission password: "  transmissionPassword
sed -i 's|{transmissionPassword}|'"${transmissionPassword}"'|' "${homeDir}/docker-compose.yml"
