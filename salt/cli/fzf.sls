{% set username = salt['environ.get']('SUDO_USER') if salt['environ.has_value']('SUDO_USER') else salt['environ.get']('USER') %}
{% set userhome = pillar['userhome'] | format( username )  %}

fzf_cloned:
  git.latest:
    - name: https://github.com/junegunn/fzf.git
    - target: {{ userhome }}/.fzf
    - user: {{ username }}
    - rev: master
    - depth: 1
    - force_fetch: True

fzf_installed:
  cmd.run:
    - name: {{ userhome }}/.fzf/install --all
    - runas: {{ username }}
    - unless:
      - which fzf

fzf_profile_installed:
   cmd.run:
     - names:
       - echo "" >> {{ userhome }}/.bashrc
       - echo "export FZF_DEFAULT_OPTS='--height 20% --layout=reverse --border'" >> {{ userhome }}/.bashrc
     - unless:
         - cat {{ userhome }}/.bashrc | grep FZF_DEFAULT_OPTS
