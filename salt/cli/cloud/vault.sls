vault_installed:
  cmd.run:
    - name:
        rm -rf /user/local/bin/vault
        && curl -LO https://releases.hashicorp.com/vault/{{ pillar['vault']['version'] }}/vault_{{ pillar['vault']['version'] }}_linux_{{ salt['grains.get']('osarch') }}.zip 
        && unzip /root/vault_{{ pillar['vault']['version'] }}_linux_{{ salt['grains.get']('osarch') }}.zip
        && mv /root/vault /usr/local/bin/vault
        && echo "complete -C /usr/local/bin/vault vault" > /etc/bash_completion.d/vault
        && rm /root/vault_{{ pillar['vault']['version'] }}_linux_{{ salt['grains.get']('osarch') }}.zip
    - runas: root
    - unless:
        # asserts vault is on our path
        - which vault
        # asserts the version of vault
        - vault version | cut -d " " -f2 | grep v{{ pillar['vault']['version'] }}
