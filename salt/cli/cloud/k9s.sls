{% set osarch = 'arm64' if salt['grains.get']('osarch') == 'arm64' else 'x86_64'  %}

k9s_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/k9s && curl -L https://github.com/derailed/k9s/releases/download/{{ pillar['k9s']['version'] }}/k9s_Linux_{{ osarch }}.tar.gz | tar xzvf - -C /usr/local/bin && chown root:root /usr/local/bin/k9s
    - runas: root
    - unless:
        # asserts ark is on our path
        - which k9s
        # asserts the version of ark
        - k9s version -s | head -n 1 | grep {{ pillar['k9s']['version'] }}
