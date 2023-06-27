{% set username = salt['environ.get']('SUDO_USER') %}

default-user-is-admin::
  user.present:
    - name: {{ username }}
    - groups:
      - sudo
