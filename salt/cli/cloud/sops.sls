sops-installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/sops
      - curl -L https://github.com/mozilla/sops/releases/download/v{{ pillar['sops']['version'] }}/sops-v{{ pillar['sops']['version'] }}.linux.{{ salt['grains.get']('osarch') }} -o /usr/local/bin/sops
      - chmod +x /usr/local/bin/sops
    - runas: root
    - unless:
        # asserts sops is on our path
        - which sops
        # asserts the version of sops
        - sops -v | cut -d " " -f2 | grep {{ pillar['sops']['version'] }}

age-installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/age*
      - curl -L https://github.com/FiloSottile/age/releases/download/{{ pillar['age']['version'] }}/age-{{ pillar['age']['version'] }}-linux-{{ salt['grains.get']('osarch') }}.tar.gz | tar xzvf - age
      - mv /root/age/age /usr/local/bin/age
      - mv /root/age/age-keygen /usr/local/bin/age-keygen
      - chmod u+x /usr/local/bin/age*
      - rm -rf /root/age-{{ pillar['age']['version'] }}-linux-{{ salt['grains.get']('osarch') }}
    - unless:
      - which age
    - cwd: /root
