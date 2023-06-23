docker-compose-installed:
  cmd.run:
    - names:
      - curl -sL https://github.com/docker/compose/releases/download/{{ pillar['docker']['compose']['version'] }}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
      - chmod +x /usr/local/bin/docker-compose
    - runas: root
    - unless: test -f /usr/local/bin/docker-compose && docker-compose version | grep {{ pillar['docker']['compose']['version'] }}
