nova_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/nova && curl -L https://github.com/FairwindsOps/nova/releases/download/{{ pillar['nova']['version'] }}/nova_{{ pillar['nova']['version'] }}_linux_amd64.tar.gz | tar xzvf - -C /usr/local/bin && chown root:root /usr/local/bin/nova
    - runas: root
    - unless:
        # asserts ark is on our path
        - which nova
        # asserts the version of ark
        - nova version | head -n 1 | cut -d " " -f1 | cut -d ":" -f2 | grep {{ pillar['nova']['version'] }}

nova_completion:
  cmd.run:
    - names:
      - nova completion bash > /etc/bash_completion.d/nova
    - unless:
      - ls /etc/bash_completion.d | grep nova
