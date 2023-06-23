
{% set zscaler_cert = pillar['zscaler']['cert'] %}

npm-conf-setting:
  cmd.run:
    - name: "npm config set strict-ssl false"
    - runas: {{ pillar['username'] }}
    - unless: test "$(npm config get strict-ssl)" == "false"

npm-conf-setting-global:
  cmd.run:
    - name: "npm config set -g strict-ssl false"
    - runas: {{ pillar['username'] }}
    - unless: test "$(npm config get -g strict-ssl)" == "false"

npm-cert-conf:
  cmd.run:
    - name: "npm config set cafile=\"{{ zscaler_cert }}\""
    - runas: {{ pillar['username'] }}
    - unless: test "$(npm config get cafile)" == "{{ zscaler_cert }}"   

npm-cert-conf-global:
  cmd.run:
    - name: "npm config set -g cafile=\"{{ zscaler_cert }}\""
    - runas: {{ pillar['username'] }}
    - unless: test "$(npm config get -g cafile)" == "{{ zscaler_cert }}"


include:
  - artifactory.npm