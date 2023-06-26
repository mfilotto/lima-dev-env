**Install Lima Dev environment**
- Create your distro: limactl start template://ubuntu-lts --tty=false
- Start your distro
  - limactl start
  - lima
- Clone lima dev env repo from Github
    - `cd /srv && sudo git clone https://github.com/mfilotto/lima-dev-env.git lima`
- Install lima dev env
    - `/srv/lima/install.sh`
