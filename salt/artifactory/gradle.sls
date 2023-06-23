{% set artifactory_url = salt['environ.get']('ARTIFACTORY_URL') %}
{% set artifactory_user = salt['environ.get']('ARTIFACTORY_USER') %}
{% set artifactory_password = salt['environ.get']('ARTIFACTORY_PASSWORD') %}
{% if artifactory_url %}

Create a file with contents from an environment variable:
  file.managed:
    - name: /tmp/hello
    - contents: 
        - {{ artifactory_url }}
        - {{ artifactory_user }}
        - {{ artifactory_password }}

{% else %}

artifactory_env_present:
  test.fail_without_changes:
    - name: "Fail - Artifactory environment variables are missing"
    - failhard: True

{% endif %}


Test state after:
  file.managed:
    - name: /tmp/after
    - contents: This is after