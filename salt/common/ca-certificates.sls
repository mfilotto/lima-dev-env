ca-certificates-files-copied:
  file.recurse:
    - name:  /usr/local/share/ca-certificates
    - source: salt://files/usr/local/share/ca-certificates

ca-certificates-installed:
  cmd.wait:
    - name: /usr/sbin/update-ca-certificates
    - watch:
      - file: ca-certificates-files-copied