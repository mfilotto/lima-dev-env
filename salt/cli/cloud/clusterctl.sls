clusterctl_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/clusterctl
      - curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/{{ pillar['clusterctl']['version'] }}/clusterctl-linux-{{ salt['grains.get']('osarch') }} -o /usr/local/bin/clusterctl
      - chmod +x /usr/local/bin/clusterctl
    - runas: root
    - unless:
        # asserts clusterctl is on our path
        - which clusterctl
        # asserts the version of clusterctl
        - clusterctl version -ojson | jq -r .clusterctl.gitVersion | grep {{ pillar['clusterctl']['version'] }}

clusterctl_completion:
  cmd.run:
    - names:
      - clusterctl completion bash > /etc/bash_completion.d/clusterctl
    - unless:
      - ls /etc/bash_completion.d | grep clusterctl
