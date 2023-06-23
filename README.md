**Warning note**
- Your WSL linux distro can only be an Ubuntu
- This Dev environement configuration uses SLN Artifactory

**Prerequisites**
- Your OS must be Windows 10, version 1903 or higher
    - To check your version: `Windows logo key + R: winver`  

**Install WSL (Ubuntu only)**
- [Enable WSL 2 feature on Windows](https://docs.microsoft.com/fr-fr/windows/wsl/install-win10#manual-installation-steps)
- [Download and install the Linux kernel update package](https://aka.ms/wsl2kernel)
- [Download and install your linux distro.s](https://docs.microsoft.com/fr-fr/windows/wsl/install-manual)

**Install Docker**
- [Install Docker Desktop Stable](https://hub.docker.com/editions/community/docker-ce-desktop-windows/)
- [Activate Docker WSL 2 based engine inside Docker Desktop](https://docs.docker.com/docker-for-windows/wsl/)

**Install Windows Terminal**
- [Install Windows Terminal](https://docs.microsoft.com/fr-fr/windows/terminal/get-started)
- Extra configuration if need:
    - [Set WSL allocated resources](https://docs.microsoft.com/fr-fr/windows/wsl/wsl-config#configure-global-options-with-wslconfig)

**Set your Windows user environment variables**
- Add ARTIFACTORY_URL: `https://artifactory.sln.nc`
- Add ARTIFACTORY_USER: `your user`
- Add ARTIFACTORY_PASSWORD: `your encrypted Artifactory password`([to be found on your Artifactory user profile](https://artifactory.sln.nc/artifactory/webapp/#/profile))
- Add WSLENV: `ARTIFACTORY_URL:ARTIFACTORY_USER:ARTIFACTORY_PASSWORD`  
  WSLENV list your environment variables you want to propagate to your wsl distros

**Install WSL Dev environment**
- Start your distro
    - Launch your distro for the first time from Windows start menu
    - Enter new UNIX username: `wsl`
    - Enter new UNIX password: `wsl`
- Clone wsl dev env repo from Gitlab SLN
    - `cd /srv && sudo git clone https://gitlab.sln.nc/archi/wsl-dev-sln.git wsl`
- Install dev env
    - `./install.sh`

**Update linux kernel
- [Kernel release notes](https://github.com/MicrosoftDocs/wsl/blob/main/WSL/kernel-release-notes.md)
- [Manually update WSL linux kernel](https://docs.microsoft.com/fr-fr/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package)
