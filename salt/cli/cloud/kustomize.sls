kustomize_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/kustomize
      - curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F{{ pillar['kustomize']['version'] }}/kustomize_{{ pillar['kustomize']['version'] }}_linux_{{ salt['grains.get']('osarch') }}.tar.gz | tar xzvf - -C /usr/local/bin
      - chown root:root /usr/local/bin/kustomize
    - runas: root
    - unless:
        # asserts ark is on our path
        - which kustomize
        # asserts the version of ark
        - kustomize version --short | cut -d " " -f1 | cut -d "/" -f2 | grep {{ pillar['kustomize']['version'] }}

kustomize_completion:
  cmd.run:
    - names:
      - kustomize completion bash > /etc/bash_completion.d/kustomize
    - onchanges:
      - cmd: kustomize_installed
