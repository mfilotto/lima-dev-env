# Node version schedule: https://github.com/nodejs/Release#release-schedule
nvm_installed:
  cmd.run:
    - names:
        - rm /usr/local/bin/n && curl -L https://raw.githubusercontent.com/tj/n/v{{ pillar['n']['version'] }}/bin/n -o /usr/local/bin/n
        - chmod +x /usr/local/bin/n
    - unless:
        # asserts the version of nvm
        - n --version | grep {{ pillar['n']['version'] }}
