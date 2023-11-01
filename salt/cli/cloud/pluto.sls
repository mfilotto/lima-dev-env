pluto_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/pluto && curl -L https://github.com/FairwindsOps/pluto/releases/download/v{{ pillar['pluto']['version'] }}/pluto_{{ pillar['pluto']['version'] }}_linux_{{ salt['grains.get']('osarch') }}.tar.gz | tar xzvf - -C /usr/local/bin && chown root:root /usr/local/bin/pluto
    - runas: root
    - unless:
        # asserts ark is on our path
        - which pluto
        # asserts the version of ark
        - pluto version | head -n 1 | cut -d " " -f1 | cut -d ":" -f2 | grep {{ pillar['pluto']['version'] }}

pluto_completion:
  cmd.run:
    - names:
      - pluto completion bash > /etc/bash_completion.d/pluto
    - unless:
      - ls /etc/bash_completion.d | grep pluto
