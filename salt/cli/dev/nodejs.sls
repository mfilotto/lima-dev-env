include:
  - .n

# Node version schedule: https://github.com/nodejs/Release#release-schedule
{% for version in salt['pillar.get']('node:versions', {}) %}

node-{{ version }}-installed:
  cmd.run:
    - name: n {{ version }}
    - unless: n ls | grep {{ version }}

{% endfor %}