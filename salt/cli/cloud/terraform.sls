terraform_installed:
  cmd.run:
    - names:
      - rm -rf /usr/local/bin/terraform && curl -L https://releases.hashicorp.com/terraform/{{ pillar['terraform']['version'] }}/terraform_{{ pillar['terraform']['version'] }}_linux_amd64.zip | gunzip > /usr/local/bin/terraform
      - chmod +x /usr/local/bin/terraform
    - runas: root
    - unless:
        # asserts terraform is on our path
        - which govc
        # asserts the version of terraform
        - terraform version | head -n 1 | cut -d " " -f2 | grep v{{ pillar['terraform']['version'] }}
