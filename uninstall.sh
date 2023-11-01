#!/bin/bash

printmainstep() {
   # 35 is purple
   echo -e "\033[35m\n== ${1} \033[37m \n"
}

printmainstep "Stop lima vm"
limactl stop -f default

printmainstep "Delete lima vm"
limactl delete default

printmainstep "Uninstall lima"
brew uninstall lima

printmainstep "Uninstall jq"
brew uninstall jq
