containerd_packages:
  pkg.latest:
    - name: containerd

containerd_folder_present:
  file.directory:
    - name: /etc/containerd

containerd_conf_present:
  cmd.run:
    - name: containerd config default > /etc/containerd/config.toml
    - unless:
      - test -f /etc/containerd/config.toml

#containerd_running:
#  cmd.run:
#    - name: containerd &
#    - unless: pidof containerd

nerdctl_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/nerdctl && curl -L https://github.com/containerd/nerdctl/releases/download/v{{ pillar['nerdctl']['version'] }}/nerdctl-{{ pillar['nerdctl']['version'] }}-linux-{{ salt['grains.get']('osarch') }}.tar.gz | tar xzvf - -C /usr/local/bin
    - runas: root
    - unless:
        # asserts ark is on our path
        - which nerdctl
        # asserts the version of ark
        - nerdctl version | head -n 1 | cut -d " " -f1 | cut -d ":" -f2 | grep {{ pillar['nerdctl']['version'] }}
