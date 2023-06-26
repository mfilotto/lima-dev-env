#!/bin/bash

printstep() {
    # 36 is blue
    echo -e "\033[36m\n== ${1} \033[37m \n"
}
printmainstep() {
   # 35 is purple
   echo -e "\033[35m\n== ${1} \033[37m \n"
}
printinfo () {
    # 32 is green
    echo -e "\033[32m==== INFO : ${1} \033[37m"
}
printwarn () {
    # 33 is yellow
    echo -e "\033[33m==== ATTENTION : ${1} \033[37m"
}
printerror () {
    # 31 is red
    echo -e "\033[31m==== ERREUR : ${1} \033[37m"
}
printcomment () {
    # 2 is grey
    echo -e "\033[2m# ${1} \033[22m"
}

OS=`lsb_release -is`
if [ $OS != "Ubuntu" ]
then
    printerror "Your lima linux distro must be an Ubuntu, this one is $OS"
    exit 1
fi

if ! command -v git &> /dev/null
then
    printerror "git must be installed"
    exit 1
fi

printmainstep "Add Saltstack apt source file"
UBUNTU_CODENAME=`lsb_release -cs`
UBUNTU_RELEASE=`lsb_release -rs`
sudo curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/ubuntu/$UBUNTU_RELEASE/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg
echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] https://repo.saltproject.io/salt/py3/ubuntu/$UBUNTU_RELEASE/amd64/latest $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/salt.list

printmainstep "Update packages"
sudo apt update

printmainstep "Install salt minion"
sudo apt install -y salt-minion

printmainstep "Configure salt minion"
cat << EOF | sudo tee /etc/salt/minion.d/masterless.conf > /dev/null
file_client: local
file_roots:
  base:
    - /srv/lima/salt
pillar_roots:
  base:
    - /srv/lima/pillar
EOF

printmainstep "Install lima dev env with salt"
sudo salt-call --local state.highstate

printmainstep "Source .bashrc"
source $HOME/.bashrc

echo "salt command example: sudo salt-call --local grains.items"
