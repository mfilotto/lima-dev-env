yq_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/yq
      - curl -L https://github.com/mikefarah/yq/releases/download/v{{ pillar['yq']['version'] }}/yq_linux_{{ salt['grains.get']('osarch') }} -o /usr/local/bin/yq
      - chmod +x /usr/local/bin/yq
    - runas: root
    - unless:
        # asserts yq is on our path
        - which yq
        # asserts the version of yq
        - yq --version | cut -d " " -f4 | grep {{ pillar['yq']['version'] }}

yq_completion:
  cmd.run:
    - names:
      - yq shell-completion bash > /etc/bash_completion.d/yq
    - onchanges:
      - cmd: yq_installed
