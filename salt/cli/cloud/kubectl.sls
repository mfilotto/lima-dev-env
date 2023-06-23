kubectl_installed:
  cmd.run:
    - names:
      - curl -LO https://storage.googleapis.com/kubernetes-release/release/{{ pillar['kubernetes']['version'] }}/bin/linux/amd64/kubectl
      - chmod +x kubectl
      - mv kubectl /usr/local/bin/
    - runas: root
    - unless:
        # asserts kubectl is on our path
        - which kubectl
        # asserts the version of kubectl
        - kubectl version --client=true --short=true | cut -d " " -f3 | grep {{ pillar['kubernetes']['version'] }}

kubectl_root_symlinked:
  file.symlink:
    - name: /usr/bin/kubectl
    - target: /usr/local/bin/kubectl

kubectl_completion:
  cmd.run:
    - names:
      - kubectl completion bash > /etc/bash_completion.d/kubectl
    - unless:
      - ls /etc/bash_completion.d | grep kubectl 
    - onchanges:
      - cmd: kubectl_installed 

kubeconfig_directory_present:
  file.directory:
    - name: /home/{{ pillar['username'] }}/.kube
    - user: {{ pillar['username'] }}

kubeconfig_files_copied:
  file.recurse:
    - name:  /home/{{ pillar['username'] }}/.kube
    - source: salt://files/home/userprofile/.kube

kubeconfig_profile_installed:
   cmd.run:
     - names:
       - echo "" >> /home/{{ pillar['username'] }}/.bashrc
       - echo "export KUBECONFIG=/home/{{ pillar['username'] }}/.kube/config.dev-reader:/home/{{ pillar['username'] }}/.kube/config.prod-reader" >> /home/{{ pillar['username'] }}/.bashrc
     - unless:
         - cat /home/{{ pillar['username'] }}/.bashrc | grep KUBECONFIG

kubectx_cloned:
  git.latest:
    - name: https://github.com/ahmetb/kubectx
    - target: /opt/kubectx

kubectx_linked:
  cmd.run:
    - names:
      - ln -s /opt/kubectx/kubectx /usr/local/bin/kctx
      - ln -s /opt/kubectx/kubens /usr/local/bin/kns
      - ln -sf /opt/kubectx/completion/kubectx.bash /etc/bash_completion.d/kctx
      - ln -sf /opt/kubectx/completion/kubens.bash /etc/bash_completion.d/kns
    - runas: root
    - unless:
      - which kns
      - which kctx

kube-ps1_cloned:
  git.latest:
    - name: https://github.com/jonmosco/kube-ps1
    - target: /opt/kube-ps1

kube-ps1_profile_installed:
   cmd.run:
     - names:
       - echo "" >> /home/{{ pillar['username'] }}/.bashrc
       - echo "PS1='[\u@\h \W \$(kube_ps1)]\$ '" >> /home/{{ pillar['username'] }}/.bashrc
       - echo "export KUBE_PS1_SYMBOL_ENABLE=false" >> /home/{{ pillar['username'] }}/.bashrc
       - echo "source /opt/kube-ps1/kube-ps1.sh" >> /home/{{ pillar['username'] }}/.bashrc
     - unless:
         - cat /home/{{ pillar['username'] }}/.bashrc | grep "/opt/kube-ps1/kube-ps1.sh"

stern_installed:
  cmd.run:
    - names:
      - curl -L https://github.com/stern/stern/releases/download/v{{ pillar['kubernetes']['stern']['version'] }}/stern_{{ pillar['kubernetes']['stern']['version'] }}_linux_amd64.tar.gz | tar xzvf - -C /usr/local/bin
      - chmod +x /usr/local/bin/stern
    - runas: root
    - unless:
      # asserts stern is on our path
      - which stern
      # asserts the version of stern
      - stern -v | head -n 1 | cut -d " " -f2 | grep {{ pillar['kubernetes']['stern']['version'] }}
