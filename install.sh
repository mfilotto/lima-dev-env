#!/bin/bash

OS=`lsb_release -is`
if [ $OS != "Ubuntu" ]
then
    echo "Your WSL linux distro must be an Ubuntu, this one is $OS"
    exit 1
fi

if ! command -v git &> /dev/null
then
    echo "git must be installed"
    exit 1
fi

echo "Check if environment variables are set"
if [ -z "$ARTIFACTORY_URL" ]
then
    echo "ARTIFACTORY_URL environment variable must be set in Windows with WSLENV to propagate"
    exit 1
fi

if [ -z "$ARTIFACTORY_USER" ]
then
    echo "ARTIFACTORY_USER environment variable must be set in Windows with WSLENV to propagate"
    exit 1
fi

if [ -z "$ARTIFACTORY_PASSWORD" ]
then
    echo "ARTIFACTORY_PASSWORD environment variable must be set in Windows with WSLENV to propagate"
    exit 1
fi

ARTIFACTORY_FQDN=${ARTIFACTORY_URL##*/}

echo "Add Artifactory apt authentication file"
cat << EOF | sudo tee /etc/apt/auth.conf.d/artifactory-auth > /dev/null
machine ${ARTIFACTORY_FQDN}
  login ${ARTIFACTORY_USER}
  password ${ARTIFACTORY_PASSWORD}
EOF

echo "Create Artifactory apt sources file"
if [ ! -f /etc/apt/sources.list.public ]
then
    echo "Backup original apt sources file"
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.public
fi
sudo cp /etc/apt/sources.list /etc/apt/sources.list.artifactory
sudo sed -i "s/deb http:\/\/archive.ubuntu.com\/ubuntu/deb [trusted=yes] https:\/\/$ARTIFACTORY_FQDN\/artifactory\/debian-archive-ubuntu-remote/g" /etc/apt/sources.list.artifactory
sudo sed -i "s/deb http:\/\/security.ubuntu.com\/ubuntu/deb [trusted=yes] https:\/\/$ARTIFACTORY_FQDN\/artifactory\/debian-security-ubuntu-remote/g" /etc/apt/sources.list.artifactory
sudo cp /etc/apt/sources.list.artifactory /etc/apt/sources.list

echo "Add Saltstack apt source file"
UBUNTU_CODENAME=`lsb_release -cs`
UBUNTU_RELEASE=`lsb_release -rs`
cat << EOF | sudo tee /etc/apt/sources.list.d/saltstack.list > /dev/null
deb [trusted=yes] https://${ARTIFACTORY_FQDN}/artifactory/debian-saltstack-ubuntu-remote/py3/ubuntu/${UBUNTU_RELEASE}/amd64/latest ${UBUNTU_CODENAME} main
EOF

echo "Update packages"
sudo apt update

echo "Install salt minion"
sudo apt install -y salt-minion

echo "Configure salt minion"
cat << EOF | sudo tee /etc/salt/minion.d/masterless.conf > /dev/null
file_client: local
file_roots:
  base:
    - /srv/wsl/salt
pillar_roots:
  base:
    - /srv/wsl/pillar
EOF

echo "salt command example: sudo salt-call --local grains.items"
