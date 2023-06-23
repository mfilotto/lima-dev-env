ncu-alt-remove:
  alternatives.remove:
    - name: ncu
    - path: {{ pillar['ncu_home'] }}