#!/bin/bash

printmainstep() {
   # 35 is purple
   echo -e "\033[35m\n== ${1} \033[37m \n"
}

printmainstep "Stop lima vm"
limactl stop -f

printmainstep "Delete lima vm"
limactl delete

printmainstep "Uninstall lima"
brew uninstall lima
