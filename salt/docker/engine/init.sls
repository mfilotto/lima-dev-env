{% set artifactory_user = pillar['artifactory']['login']['user'] %}
{% set artifactory_password = pillar['artifactory']['login']['password'] %}
{% set lsb_distrib_codename = grains['lsb_distrib_codename'] %}

# No more needed with Docker WSL 2 based engine
#docker-env-installed:
#  file.managed:
#    - name: /etc/profile.d/env-docker.sh 
#    - contents:
#        - export DOCKER_HOST=tcp://localhost:2375

docker-required-packages:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - tree
      - curl
      - gnupg-agent
      - software-properties-common

# {% if artifactory_user %}
# docker_repo_installed:
#   file.managed:
#     - name: /etc/apt/sources.list.d/artifactory.list
#     - contents: |
#         deb [arch=amd64] {{ pillar['artifactory']['repos']['docker-yum'] | format( user, password ) }}
#         proxy=_none_
# {% else %}
# docker-repo:
#   pkgrepo.managed:
#     - name: deb {{ pillar['docker']['repo']['baseurl'] }} {{ lsb_distrib_codename }} stable
#     - dist: {{ lsb_distrib_codename }}
#     - file: /etc/apt/sources.list.d/artifactory-docker.list
# {% endif %}

docker-pkg:
  pkg.installed:
    - name: {{ pillar['docker']['pkg']['name'] }}
   # - version: {{ pillar['docker']['pkg']['version'] }}
