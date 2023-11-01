gitops-zombies_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/gitops-zombies
      - curl -L https://github.com/raffis/gitops-zombies/releases/download/v{{ pillar['gitops-zombies']['version'] }}/gitops-zombies_{{ pillar['gitops-zombies']['version'] }}_linux_{{ salt['grains.get']('osarch') }}.tar.gz | tar xz -C /tmp
      - chown root:root /tmp/gitops-zombies
      - mv /tmp/gitops-zombies /usr/local/bin
    - runas: root
    - unless:
        # asserts gitops-zombies is on our path
        - which gitops-zombies
        # asserts the version of gitops-zombies
        - gitops-zombies version | tail -n 1 | cut -d "/" -f2 | grep {{ pillar['gitops-zombies']['version'] }}

