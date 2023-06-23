fzf_cloned:
  git.latest:
    - name: https://github.com/junegunn/fzf.git
    - target: /home/{{ pillar['username'] }}/.fzf
    - user: {{ pillar['username'] }}
    - rev: master
    - depth: 1

fzf_installed:
  cmd.run:
    - name: /home/{{ pillar['username'] }}/.fzf/install --all
    - runas: {{ pillar['username'] }}
    - unless:
      - which fzf

fzf_profile_installed:
   cmd.run:
     - names:
       - echo "" >> /home/{{ pillar['username'] }}/.bashrc
       - echo "export FZF_DEFAULT_OPTS='--height 20% --layout=reverse --border'" >> /home/{{ pillar['username'] }}/.bashrc
     - unless:
         - cat /home/{{ pillar['username'] }}/.bashrc | grep FZF_DEFAULT_OPTS
