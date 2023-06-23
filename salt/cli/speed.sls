no_proxy_configured:
  environ.setenv:
    - name: no_proxy
    - value: {{ pillar['proxy']['no_proxy'] }}

speed_client_cloned:
  git.latest:
    - name: https://{{ pillar['gitlab']['user'] }}:{{ pillar['gitlab']['password'] }}@{{ pillar['gitlab']['server'] }}/speed/speed-client.git
    - target: /opt/speed

speed_client_linked:
  cmd.run:
    - names:
      - chmod +x /opt/speed/compile
      - chmod +x /opt/speed/dockerize
      - chmod +x /opt/speed/deploy
      - chmod +x /opt/speed/chartify
      - ln -s /opt/speed/init_speed_env /usr/local/bin/init_speed_env
      - ln -s /opt/speed/compile /usr/local/bin/compile
      - ln -s /opt/speed/dockerize /usr/local/bin/dockerize
      - ln -s /opt/speed/deploy /usr/local/bin/deploy
      - ln -s /opt/speed/chartify /usr/local/bin/chartify
    - runas: root
    - unless:
      - which compile
      - which dockerize
      - which deploy
      - which chartify
