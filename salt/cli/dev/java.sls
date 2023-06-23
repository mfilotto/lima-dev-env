{% for version in salt['pillar.get']('java:versions', {}) %}

java-{{ version }}-installed:
  pkg.installed:
    - pkgs:
      - openjdk-{{ version }}-jdk

{% endfor %}