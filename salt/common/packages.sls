common_packages:
  pkg.latest:
    - pkgs:
      - bat
      #- curl
      #- wget
      #- htop
      #- strace
      #- vim-enhanced
      #- nano
      - dos2unix
      #- git
      - unzip
      - jq
      - tree
      #- nmap-ncat
      #- telnet

batcat_symlinked:
  file.symlink:
    - name: /usr/bin/bat
    - target: /usr/bin/batcat

git-color-config:
  cmd.run:
    - name: "git config --global color.ui auto"
    - unless: test "$(git config --global --get color.ui)" == "auto"

git-autocrlf-config:
  cmd.run:
    - name: "git config --global core.autocrlf input"
    - unless: test "$(git config --global --get core.autocrlf)" == "input"

git-eol-config:
  cmd.run:
    - name: "git config --global core.eol lf"
    - unless: test "$(git config --global --get core.eol)" == "lf"
