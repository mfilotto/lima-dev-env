ksd_installed:
  cmd.run:
    - names:
      - go get github.com/mfuentesg/ksd
    - runas: root
    - unless:
        # asserts govc is on our path
        - which ksd
        # asserts the version of govc
        # - govc version | cut -d " " -f2 | grep {{ pillar['govc']['version'] }}
