kind_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/kind
      - curl -Lo /usr/local/bin/kind https://github.com/kubernetes-sigs/kind/releases/download/{{ pillar['kind']['version'] }}/kind-linux-amd64
      - chmod +x /usr/local/bin/kind
    - runas: root
    - unless:
        # asserts kind is on our path
        - which kind
        # asserts the version of kind
        - kind version | cut -d " " -f2 | grep {{ pillar['kind']['version'] }}

kind_completion:
  cmd.run:
    - names:
      - kind completion bash > /etc/bash_completion.d/kind
    - unless:
      - ls /etc/bash_completion.d | grep kind
