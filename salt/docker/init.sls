include:
  - docker.engine
  - docker.compose

docker-group-added:
  group.present:
    - name: docker
    - gid:
    - members:
      - vagrant
