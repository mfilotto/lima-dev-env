include:
  - common.proxy

azure-functions-core-tools_installed:
  cmd.run:
    - names:
      - rm -rf /opt/azure-functions-core-tools && mkdir /opt/azure-functions-core-tools
      - cd /opt/azure-functions-core-tools && curl -LO https://github.com/Azure/azure-functions-core-tools/releases/download/{{ pillar['azure-functions-core-tools']['version'] }}/Azure.Functions.Cli.linux-x64.{{ pillar['azure-functions-core-tools']['version'] }}.zip
      - gunzip -c /opt/azure-functions-core-tools/Azure.Functions.Cli.linux-x64.{{ pillar['azure-functions-core-tools']['version'] }}.zip
      - chmod +x /opt/azure-functions-core-tools/func
      - chmod +x /opt/azure-functions-core-tools/gozip
      - ln -s /opt/azure-functions-core-tools/func /usr/local/bin/func
    - runas: root
    - unless:
        # asserts func is on our path
        - which func
        # asserts the version of func
        - func --version | grep v{{ pillar['azure-functions-core-tools']['version'] }}
