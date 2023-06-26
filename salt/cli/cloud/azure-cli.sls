azure-cli-signing-key-installed:
  cmd.run:
    - names:
      - mkdir -p /etc/apt/keyrings
      - curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null
      - chmod go+r /etc/apt/keyrings/microsoft.gpg
    - runas: root
    - unless:
      - which az
      - az version | grep {{ pillar['azure-cli']['version'] }}

azure-cli-repo-installed:
  cmd.run:
    - names:
      - echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
    - runas: root
    - unless:
      - which az
      - az version | grep {{ pillar['azure-cli']['version'] }}

azure-cli-installed:
  pkg.installed:
    - name: azure-cli
    - version: {{ pillar['azure-cli']['version'] }}-1~jammy
    - runas: root