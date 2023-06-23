azure-cli-repo:
  pkgrepo.managed:
    - name: deb {{ pillar['azure-cli']['repo']['baseurl'] }} bionic main
    - humanname: Azure CLI
    - enable: 1
    - gpgcheck: 0

azure-cli_installed:
  pkg.installed:
    - name: azure-cli
    - version: {{ pillar['azure-cli']['version'] }}-1~bionic
