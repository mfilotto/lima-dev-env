**Install Lima Dev environment**
- Create your distro: limactl start --name=default template://ubuntu-lts --tty=false
- Start your distro
  - limactl start default
  - lima
- Clone lima dev env repo from Github
    - `cd /srv && sudo git clone https://github.com/mfilotto/lima-dev-env.git lima`
- Install dev env
    - `./install.sh`
