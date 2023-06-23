npm-install-commitizen:
  npm.installed:
    - pkgs:
      - commitizen
      - cz-conventional-changelog

cz-path-set:
  file.append:
    - name: /home/{{ pillar['username'] }}/.czrc
    - text: " { \"path\": \"cz-conventional-changelog\"} "
