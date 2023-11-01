{% set osarch = 'arm64' if salt['grains.get']('osarch') == 'arm64' else 'x86_64'  %}
ksd_installed:
  cmd.run:
    - names:
      - curl -L https://github.com/mfuentesg/ksd/releases/download/v{{ pillar['ksd']['version'] }}/ksd_{{ pillar['ksd']['version'] }}_Linux_{{ osarch }}.tar.gz | tar xzvf - -C /usr/local/bin
      - chmod +x /usr/local/bin/ksd
    - runas: root
    - unless:
      # asserts ksd is on our path
      - which ksd
      # asserts the version of stern
      - ksd version | cut -d " " -f3 | grep {{ pillar['ksd']['version'] }}