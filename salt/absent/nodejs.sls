{% set base_path = "/usr/local/bin/nodes/%s/bin/node" %}

{% for version in salt['pillar.get']('node:versions', {}) %}

{{ version }}-alt-remove:
  alternatives.remove:
    - name: node
    - path: {{ base_path|format( version ) }}

{{ version }}-dir-remove:
  file.absent:
      - name: /usr/local/bin/nodes/{{ version }}

{% endfor %}