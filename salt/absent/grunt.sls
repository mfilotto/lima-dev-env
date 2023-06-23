grunt-alt-remove:
  alternatives.remove:
    - name: grunt
    - path: {{ pillar['grunt_home'] }}