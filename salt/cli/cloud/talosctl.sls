talosctl_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/talosctl
      - curl -L https://github.com/siderolabs/talos/releases/download/{{ pillar['talosctl']['version'] }}/talosctl-linux-amd64 -o /usr/local/bin/talosctl
      - chmod +x /usr/local/bin/talosctl
    - runas: root
    - unless:
        # asserts talosctl is on our path
        - which talosctl
        # asserts the version of talosctl
        - talosctl version --short --client | tail -n 1 | cut -d " " -f2 | grep {{ pillar['talosctl']['version'] }}

talosctl_completion:
  cmd.run:
    - names:
      - talosctl completion bash > /etc/bash_completion.d/talosctl
    - unless:
      - ls /etc/bash_completion.d | grep talosctl
