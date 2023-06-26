**Warning note**
- Your Lima linux distro can only be an Ubuntu

**Install Lima Dev environment**
- Create your distro:
  - `limactl start --name=default template://ubuntu-lts --tty=false`
- Start your distro
  - `limactl start`
  - `lima`
- Clone lima dev env from Github repo
    - `cd /srv && sudo git clone https://github.com/mfilotto/lima-dev-env.git lima`
- Install lima dev env
    - `/srv/lima/install.sh`
