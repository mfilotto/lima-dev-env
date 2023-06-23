env_proxy_configured:
  file.managed:
    - name: /etc/profile.d/env-proxy.sh
    - contents: 
      - export http_proxy={{ pillar['proxy']['http_proxy'] }}
      - export https_proxy={{ pillar['proxy']['http_proxy'] }}
      - export no_proxy={{ pillar['proxy']['no_proxy'] }}

http_proxy_configured:
  environ.setenv:
    - name: http_proxy
    - value: {{ pillar['proxy']['http_proxy'] }}

https_proxy_configured:
  environ.setenv:
    - name: https_proxy
    - value: {{ pillar['proxy']['http_proxy'] }}

no_proxy_configured:
  environ.setenv:
    - name: no_proxy
    - value: {{ pillar['proxy']['no_proxy'] }}