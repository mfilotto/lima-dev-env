{% set tar_path_gradle = "gradle-%s-bin.zip" %}
{% set bin_path_gradle = "gradle" %}
{% set base_path_gradle = "gradle-%s" %}

{% for version in salt['pillar.get']('gradle:versions', {}) %}

gradle-{{ version }}-alt-remove:
  alternatives.remove:
    - name: gradle
    - path: /usr/local/bin/{{ bin_path_gradle }}/{{ base_path_gradle|format( version ) }}/bin/gradle

gradle-{{ version }}-dir-remove:
  file.absent:
    - name: /usr/local/bin/{{ bin_path_gradle }}

{% endfor %}

gradle-init-remove:
  file.absent:
    - name: /home/vagrant/.gradle/init.gradle