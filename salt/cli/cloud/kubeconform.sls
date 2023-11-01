kubeconform-installed:
  cmd.run:
    - names:
      - mkdir -p /root/linux-{{ salt['grains.get']('osarch') }}/kubeconform
      - rm -rf /usr/local/bin/kubeconform && curl -L https://github.com/yannh/kubeconform/releases/download/{{ pillar['kubeconform']['version'] }}/kubeconform-linux-{{ salt['grains.get']('osarch') }}.tar.gz | tar xzvf - -C /root/linux-{{ salt['grains.get']('osarch') }}/kubeconform
      - mv /root/linux-{{ salt['grains.get']('osarch') }}/kubeconform/kubeconform /usr/local/bin/kubeconform
      - rm -rf /root/linux-{{ salt['grains.get']('osarch') }}
      - chmod +x /usr/local/bin/kubeconform
      - chown root:root /usr/local/bin/kubeconform
    - runas: root
    - unless:
        # asserts kubeconform is on our path
        - which kubeconform
        # asserts the version of kubeconform
        - kubeconform -v | grep {{ pillar['kubeconform']['version'] }}
