{% set username = salt['environ.get']('SUDO_USER') if salt['environ.has_value']('SUDO_USER') else salt['environ.get']('USER') %}

default-user-is-admin::
  user.present:
    - name: {{ username }}
    - groups:
      - sudo
