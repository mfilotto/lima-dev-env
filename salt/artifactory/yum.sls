{% set user = pillar['artifactory']['login']['user'] %}
{% set password = pillar['artifactory']['login']['password'] %}

centos_repos_absent:
  cmd.run:
    - name: rm -f /etc/yum.repos.d/CentOS-*
    - onlyif:
      - ls /etc/yum.repos.d/CentOS-* > /dev/null 2>&1

saltstack_repos_absent:
  cmd.run:
    - name: rm -f /etc/yum.repos.d/saltstack.repo
    - onlyif:
      - test -f /etc/yum.repos.d/saltstack.repo

epel_repos_absent:
  cmd.run:
    - name: rm -f /etc/yum.repos.d/epel.repo
    - onlyif:
      - test -f /etc/yum.repos.d/epel.repo

epel_testing_repos_absent:
  cmd.run:
    - name: rm -f /etc/yum.repos.d/epel-testing.repo
    - onlyif:
      - test -f /etc/yum.repos.d/epel-testing.repo

artifactory_repo_installed:
  file.managed:
    - name: /etc/yum.repos.d/Artifactory.repo
    - contents: |
        [Artifactory]
        name=Artifactory
        enable=1
        enabled=1
        gpgcheck=0
        baseurl={{ pillar['artifactory']['repos']['yum'] | format( user, password ) }}
        proxy=_none_