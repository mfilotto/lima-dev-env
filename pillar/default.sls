# Defaut pillar values
userhome: /home/%s.linux

locale: fr_FR.UTF-8

proxy:
  http_proxy: 
  no_proxy: localhost,127.0.0.1

artifactory:
  repos:
    yum: https://%s:%s@artifactory.sln.nc/artifactory/rpm-centos7
    docker-yum: https://%s:%s@artifactory.sln.nc/artifactory/rpm-centos7-docker-ce/

zscaler:
  cert: /usr/local/share/ca-certificates/zscaler/ZscalerRootCA.crt

gitlab:
  server: 
  user: 
  password: 

docker:
  pkg:
    name: docker-ce
    version: 19.03.8
  repo:
    baseurl: https://download.docker.com/linux/ubuntu
  compose:
    version: 1.29.2

nerdctl:
  version: 1.0.0

kubernetes:
  version: v1.24.8
  repo:
    baseurl: https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
  helm:
    version: v3.11.0
  stern:
    version: 1.22.0

ksd:
  version: 1.0.7

kustomize:
  version: v4.5.7

kubeconform:
  version: v0.5.0

clusterctl:
  version: v1.2.4

kind:
  version: v0.16.0

flux:
  version: 2.0.1

gitops:
  version: v0.10.0

gitops-zombies:
  version: 0.0.9

talosctl:
  version: v1.2.5 

k9s:
  version: v0.27.4

nova:
  version: 3.2.0

pluto:
  version: 5.11.2

kubent:
  version: 0.5.1

velero:
  version: v1.9.4

vault:
  version: 1.12.0

sops:
  version: 3.7.3

age:
  version: v1.0.0

govc:
  version: 0.27.4

azure-cli:
  version: 2.53.0
  repo:
    baseurl: https://packages.microsoft.com/repos/azure-cli

azure-functions-core-tools:
  version: 3.0.2798

terraform:
  version: 1.4.4

yq:
  version: 4.29.2

n:
  version: 6.4.0

# Node version schedule: https://github.com/nodejs/Release#release-schedule
node:
  versions:
    - 10.21.0 # dubnium
    - 12.18.1 # erbium installed last to be the default
    - 16.19.0

gradle:
  versions:
    - 4.0

java:
  versions:
   - 8
