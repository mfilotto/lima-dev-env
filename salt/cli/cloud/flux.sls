flux_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/flux
      - curl -L https://github.com/fluxcd/flux2/releases/download/v{{ pillar['flux']['version'] }}/flux_{{ pillar['flux']['version'] }}_Linux_{{ salt['grains.get']('osarch') }}.tar.gz | tar xzvf - -C /usr/local/bin
      - chown root:root /usr/local/bin/flux
    - runas: root
    - unless:
        # asserts ark is on our path
        - which flux
        # asserts the version of ark
        - flux version --client | cut -d ":" -f2 | grep {{ pillar['flux']['version'] }}

flux_completion:
  cmd.run:
    - names:
      - flux completion bash > /etc/bash_completion.d/flux
    - onchanges:
      - cmd: flux_installed
