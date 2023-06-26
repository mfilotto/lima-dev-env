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

echo "Add Saltstack apt source file"
UBUNTU_CODENAME=`lsb_release -cs`
UBUNTU_RELEASE=`lsb_release -rs`
sudo curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/ubuntu/$UBUNTU_RELEASE/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg
echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] https://repo.saltproject.io/salt/py3/ubuntu/$UBUNTU_RELEASE/amd64/latest $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/salt.list


echo "Update packages"
sudo apt update

echo "Install salt minion"
sudo apt install -y salt-minion

echo "Configure salt minion"
cat << EOF | sudo tee /etc/salt/minion.d/masterless.conf > /dev/null
file_client: local
file_roots:
  base:
    - /srv/lima/salt
pillar_roots:
  base:
    - /srv/lima/pillar
EOF

echo "Install dev env"
sudo salt-call --local state.highstate

echo "salt command example: sudo salt-call --local grains.items"
