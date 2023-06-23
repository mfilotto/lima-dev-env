kubeconform-installed:
  cmd.run:
    - names:
      - mkdir -p /root/linux-amd64/kubeconform
      - rm -rf /usr/local/bin/kubeconform && curl -L https://github.com/yannh/kubeconform/releases/download/{{ pillar['kubeconform']['version'] }}/kubeconform-linux-amd64.tar.gz | tar xzvf - -C /root/linux-amd64/kubeconform
      - mv /root/linux-amd64/kubeconform/kubeconform /usr/local/bin/kubeconform
      - rm -rf /root/linux-amd64
      - chmod +x /usr/local/bin/kubeconform
      - chown root:root /usr/local/bin/kubeconform
    - runas: root
    - unless:
        # asserts kubeconform is on our path
        - which kubeconform
        # asserts the version of kubeconform
        - kubeconform -v | grep {{ pillar['kubeconform']['version'] }}
