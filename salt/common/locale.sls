env_locale_configured:
  file.managed:
    - name: /etc/profile.d/locale.sh
    - contents:
      - export LC_CTYPE={{ pillar['locale'] }}
      - export LC_ALL={{ pillar['locale'] }}
