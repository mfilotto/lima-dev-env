gitops_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/gitops
      - curl -L https://github.com/weaveworks/weave-gitops/releases/download/{{ pillar['gitops']['version'] }}/gitops-linux-x86_64.tar.gz | tar xz -C /tmp
      - chown root:root /tmp/gitops
      - mv /tmp/gitops /usr/local/bin
    - runas: root
    - unless:
        # asserts gitops is on our path
        - which gitops
        # asserts the version of gitops
        - gitops version | tail -n 1 | cut -d "/" -f2 | grep {{ pillar['gitops']['version'] }}

gitops_completion:
  cmd.run:
    - names:
      - gitops completion bash > /etc/bash_completion.d/gitops
    - onchanges:
      - cmd: gitops_installed
