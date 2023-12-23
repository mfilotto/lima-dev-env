google-cloud-cli-signing-key-installed:
  cmd.run:
    - names:
      - mkdir -p /etc/apt/keyrings
      - curl -sLS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg> /dev/null
      - chmod go+r /usr/share/keyrings/cloud.google.gpg
    - runas: root
    - unless:
      - which gcloud
      - gcloud version | grep {{ pillar['google-cloud-cli']['version'] }}

google-cloud-cli-repo-installed:
  cmd.run:
    - names:
      - echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    - runas: root
    - unless:
      - which gcloud
      - gcloud version | grep {{ pillar['google-cloud-cli']['version'] }}
    - require:
      - cmd: google-cloud-cli-signing-key-installed

google-cloud-cli-installed:
  pkg.installed:
    - name: google-cloud-cli
    - version: {{ pillar['google-cloud-cli']['version'] }}-0
    - runas: root
    - require:
      - cmd: google-cloud-cli-signing-key-installed
      - cmd: google-cloud-cli-repo-installed