{% set username = salt['environ.get']('SUDO_USER') %}

ksd_installed:
  cmd.run:
    - names:
      - go install github.com/mfuentesg/ksd@latest
      - source /etc/profile.d/*
    - runas: {{ username }}
    - unless:
        # asserts govc is on our path
        - runuser -l {{ username }} -c 'which ksd'
        # asserts the version of govc
        # - govc version | cut -d " " -f2 | grep {{ pillar['govc']['version'] }}
