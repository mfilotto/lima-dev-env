kubent_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/kubent && curl -L https://github.com/doitintl/kube-no-trouble/releases/download/{{ pillar['kubent']['version'] }}/kubent-{{ pillar['kubent']['version'] }}-linux-amd64.tar.gz | tar xzvf - -C /usr/local/bin && chown root:root /usr/local/bin/kubent
    - runas: root
    - unless:
        # asserts kubent is on our path
        - which kubent
        # asserts the version of ark
        - kubent version | head -n 1 | cut -d " " -f1 | cut -d ":" -f2 | grep {{ pillar['kubent']['version'] }}
