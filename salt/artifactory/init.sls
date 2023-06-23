{% set artifactory_user = pillar['artifactory']['login']['user'] %}
{% set artifactory_password = pillar['artifactory']['login']['password'] %}
{% set artifactory_url = pillar['artifactory']['url'] %}
{% if not (artifactory_url and artifactory_user and artifactory_password) %}

artifactory_env_present:
  test.fail_without_changes:
    - name: "Fail - Artifactory are missing in env pillar file"
    - failhard: True

{% else %}

Create a file with contents from an environment variable:
  file.managed:
    - name: /tmp/artifactory
    - contents: 
        - {{ artifactory_url }}
        - {{ artifactory_user }}
        - {{ artifactory_password }}

{% endif %}
