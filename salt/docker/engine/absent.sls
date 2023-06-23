docker-service-absent:
  service.dead:  
    - name: docker
    - enable: False

docker-registry-certs:
  file.absent:
    - name: /etc/docker
    - require:
      - service: docker-service-absent

docker-pkg:  
  pkg.purged:
    - name: docker-ce
    - require:
      - service: docker-service-absent

docker-repo-absent:
  pkgrepo.absent:
    - name: Docker_latest
