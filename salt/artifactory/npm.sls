{% set artifactory_user = pillar['artifactory']['login']['user'] %}
{% set artifactory_password = pillar['artifactory']['login']['password'] %}
{% set artifactory_url = pillar['artifactory']['url'] %}

artifactory_npm_registry_added:
  cmd.run:
    - names:
      - curl --noproxy '*' -u {{ artifactory_user }}:{{ artifactory_password }} {{ artifactory_url }}/artifactory/api/npm/auth > /home/{{ pillar['username'] }}/.npmrc 
      - echo registry={{ artifactory_url }}/artifactory/api/npm/npm/ >> /home/{{ pillar['username'] }}/.npmrc
      - curl --noproxy '*' -u {{ artifactory_user }}:{{ artifactory_password }} {{ artifactory_url }}/artifactory/api/npm/auth > /root/.npmrc 
      - echo registry={{ artifactory_url }}/artifactory/api/npm/npm/ >> /root/.npmrc
    - unless:
      - cat /home/{{ pillar['username'] }}/.npmrc | grep {{ artifactory_url }}
      - cat /root/.npmrc | grep {{ artifactory_url }}