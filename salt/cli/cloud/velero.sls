velero-installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/velero
      - curl -L https://github.com/vmware-tanzu/velero/releases/download/{{ pillar['velero']['version'] }}/velero-{{ pillar['velero']['version'] }}-linux-amd64.tar.gz | tar xzvf - velero-{{ pillar['velero']['version'] }}-linux-amd64/velero
      - mv /root/velero-{{ pillar['velero']['version'] }}-linux-amd64/velero /usr/local/bin/velero
      - chown root:root /usr/local/bin/velero
      - chmod u+x /usr/local/bin/velero
      - rm -rf /root/velero-{{ pillar['velero']['version'] }}-linux-amd64
    - unless: 
      - which velero
      - velero version --client-only | tail -n 2 | head -n 1 | cut -d " " -f2 | grep {{ pillar['velero']['version'] }}
    - cwd: /root

velero_completion:
  cmd.run:
    - names:
      - velero completion bash > /etc/bash_completion.d/velero
    - unless:
      - ls /etc/bash_completion.d | grep velero
