#!/bin/bash

set -euxo pipefail

if [ "$EUID" -ne 0 ]
then
    echo "Please run as root."
    exit
fi

echo "Please set password root:"
passwd

apt-get purge -y docker docker-engine docker.io containerd runc
apt-get update -y
apt-get upgrade -y
apt-get install apt-transport-https ca-certificates gnupg-agent software-properties-common
wget -O - -q https://download.docker.com/linux/debian/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

docker login
