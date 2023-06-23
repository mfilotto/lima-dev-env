{% from "cli/dev/golang/map.jinja" import golang with context %}
# Installing Golang is pretty easy, thanks Googs, so basically all we need to
# do is pull down an archive and unpack it somewhere.  To allow for versioning,
# we use a extract the tarball to <prefix>/golang/<version>/go and then create
# a symlink back to `golang:lookup:go_root` which defaults to /usr/local/go

# Create directories
golang|create-directories:
  file.directory:
    - names:
        - {{ golang.base_dir }}
        - {{ golang.go_path }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - unless:
        - test -d {{ golang.base_dir }}
    - recurse:
        - user
        - group
        - mode

# Extract the archive locally to golang:lookup:base_dir: which has our version
# schema already baked in and extract the archive if necessary
golang|extract-archive:
  cmd.run:
    - name: "curl -L https://go.dev/dl/{{ golang.archive_name }} | tar zxvf - -C {{ golang.base_dir }}"
    - runas: root
    - unless:
        # asserts go is on our path
        - which go
        # asserts the version of go
        - test -x {{ golang.base_dir }}/go/bin/go
        # asserts go version
        #- go version | cut -d " " -f3  | cut -d "o" -f2 | grep {{ golang.version }}

# add a symlink from versioned install to point at golang:lookup:go_root
golang|update-alternatives:
  alternatives.install:
    - name: golang-home
    - link: {{ golang.go_root }}
    - path: {{ golang.base_dir }}/go/
    - priority: {{ golang.priority }}
    - order: 10
    - watch:
        - cmd: golang|extract-archive

# add symlinks to /usr/bin for the three go commands
{% for i in ['go', 'gofmt'] %}
golang|create-symlink-{{ i }}:
  alternatives.install:
    - name: {{ i }}
    - link: /usr/bin/{{ i }}
    - path: {{ golang.go_root }}/bin/{{ i }}
    - priority: {{ golang.priority }}
    - order: 10
    - watch:
        - cmd: golang|extract-archive
{% endfor %}

# sets up the necessary environment variables required for golang usage
golang|setup-bash-profile:
  file.managed:
    - name: /etc/profile.d/golang.sh
    - source:
        - salt://cli/dev/golang/files/go_profile.sh
    - template: jinja
    - mode: 644
    - user: root
    - group: root
