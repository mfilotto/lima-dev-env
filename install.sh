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

if ! command -v git &> /dev/null
then
    printerror "git must be installed"
    exit 1
fi

WORKSPACE="$HOME/workspace"

if ! command -v jq &> /dev/null
then
    printmainstep "Install jq with brew"
    brew install jq
fi

if ! command -v lima &> /dev/null
then
    printmainstep "Install lima with brew"
    brew install lima
fi

printmainstep "Create workspace folder $WORKSPACE"
mkdir -p $WORKSPACE

if ! limactl list -q | grep -q default; then
    printmainstep "Create your distro"
    TEMPLATE=$(limactl info | jq -r '.templates[] | select(.name=="ubuntu-lts")'.location)
    cat $TEMPLATE | sed 's/~/~\/workspace/g' | sed -e '/.*~\/workspace.*/a\
  writable: true' | limactl start --name=default --tty=false -
fi

if ! test -d $WORKSPACE/lima-dev-env; then
    printmainstep "Clone lima dev env from Github repo"
    limactl shell --workdir $WORKSPACE default sh -c 'sudo git clone https://github.com/mfilotto/lima-dev-env.git'
else 
    printmainstep "Pull lima dev env from Github repo"
    limactl shell --workdir $WORKSPACE/lima-dev-env default sh -c 'sudo git pull'
fi

printmainstep "Add Saltstack apt source file"
limactl shell --debug default sh -c 'sudo curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/ubuntu/`lsb_release -rs`/`dpkg --print-architecture`/SALT-PROJECT-GPG-PUBKEY-2023.gpg'
limactl shell --debug default sh -c 'echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=`dpkg --print-architecture`] https://repo.saltproject.io/salt/py3/ubuntu/`lsb_release -rs`/`dpkg --print-architecture`/latest `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/salt.list'

printmainstep "Update packages"
lima sudo apt update

printmainstep "Install salt minion"
lima sudo apt install -y salt-minion

printmainstep "Configure salt minion"
limactl shell --workdir $WORKSPACE --debug default sh -c 'cat << EOF | sudo tee /etc/salt/minion.d/masterless.conf > /dev/null
file_client: local
file_roots:
  base:
    - $PWD/lima-dev-env/salt
pillar_roots:
  base:
    - $PWD/lima-dev-env/pillar
EOF'

printmainstep "Install lima dev env with salt"
lima sudo salt-call --local state.highstate

printmainstep "Source .bashrc"
#lima source $HOME/.bashrc
#limactl shell --debug default bash 'source <(cat /etc/profile.d/*)'

printmainstep "Enter inside lima vm in workspace folder"
limactl shell --workdir $WORKSPACE default

#echo "salt command example: sudo salt-call --local grains.items"
