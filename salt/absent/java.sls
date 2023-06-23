{% for version in salt['pillar.get']('java:versions', {}) %}

java-{{ version }}-remove:
  pkg.removed:
    - pkgs:
      - java
      - java-{{ version }}-openjdk
      - java-{{ version }}-openjdk-devel

{% endfor %}