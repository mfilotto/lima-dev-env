govc-env-installed:
  file.managed:
    - name: /etc/profile.d/env-govc.sh 
    - contents:
        - export GOVC_URL=dbk-vcenter-01v.oceania.ecm.era
        - export GOVC_INSECURE=1
        - export GOVC_USERNAME='OCEANIA\SVC-DBK-KUBERNETES'
        - export GOVC_PASSWORD=XXX
        - export GOVC_DATASTORE='SYLVER-VM-KUBERNETES'

govc-installed:
  cmd.run:
    - names:
      - mkdir -p /root/linux-amd64/govc
      - rm -rf /usr/local/bin/govc && curl -L https://github.com/vmware/govmomi/releases/download/v{{ pillar['govc']['version'] }}/govc_Linux_x86_64.tar.gz | tar xzvf - -C /root/linux-amd64/govc
      - mv /root/linux-amd64/govc/govc /usr/local/bin/govc
      - rm -rf /root/linux-amd64
      - chmod +x /usr/local/bin/govc
      - chown root:root /usr/local/bin/govc
    - runas: root
    - unless:
        # asserts govc is on our path
        - which govc
        # asserts the version of govc
        - govc version | cut -d " " -f2 | grep {{ pillar['govc']['version'] }}

govc-completion-installed:
  cmd.run:
    - name: curl -L https://raw.githubusercontent.com/vmware/govmomi/v{{ pillar['govc']['version'] }}/scripts/govc_bash_completion -o /etc/bash_completion.d/govc
    - unless:
        # asserts govc is on our path
        - which govc
        # asserts the version of govc
        - govc version | cut -d " " -f2 | grep {{ pillar['govc']['version'] }}
