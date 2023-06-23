{% for version in salt['pillar.get']('npm:versions', {}) %}

npm-alt-remove-{{ version }}:
  alternatives.remove:
    - name: npm
    - path: /usr/local/bin/nodes/{{ version }}/bin/npm

{% endfor %}