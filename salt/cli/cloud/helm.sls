{% set username = salt['environ.get']('SUDO_USER') if salt['environ.has_value']('SUDO_USER') else salt['environ.get']('USER') %}

helm-installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/helm && curl https://get.helm.sh/helm-{{ pillar['kubernetes']['helm']['version'] }}-linux-{{ salt['grains.get']('osarch') }}.tar.gz | tar xzvf - -C /root/ linux-{{ salt['grains.get']('osarch') }}/helm
      - mv /root/linux-{{ salt['grains.get']('osarch') }}/helm /usr/local/bin
      - chown root:root /usr/local/bin/helm
      - chmod u+x /usr/local/bin/helm
      - rm -rf /root/linux-{{ salt['grains.get']('osarch') }}
    - unless: runuser -l {{ username }} -c 'helm version --client | cut -d "\"" -f2 | grep {{ pillar['kubernetes']['helm']['version'] }}'

helm_completion:
  cmd.run:
    - names:
      - helm completion bash > /etc/bash_completion.d/helm
    - onchanges:
      - cmd: helm-installed
