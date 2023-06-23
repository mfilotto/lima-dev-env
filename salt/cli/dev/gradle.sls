gradle-init-create:
  file.managed:
    - name: /home/{{ pillar['username'] }}/.gradle/init.gradle
    - create: true
    - makedirs : true
    - contents: |
        initscript {
            repositories {
                maven{
                    url System.properties['artifactory_release_url']
                    credentials {
                        username System.properties['artifactory_user']
                        password System.properties['artifactory_password']
                    }
                }
            }
        }
        apply plugin:EnterpriseRepositoryPlugin
        class EnterpriseRepositoryPlugin implements Plugin<Gradle> {
            void apply(Gradle gradle) {
                gradle.allprojects{ project ->
                    project.repositories {
                        // Remove all repositories not pointing to the enterprise repository url
                        all { ArtifactRepository repo ->
                            if (repo instanceof MavenArtifactRepository && !repo.url.toString().startsWith(System.properties['artifactory_release_url'])) {
                                project.logger.lifecycle "Repository ${repo.url} removed. Only ${System.properties['artifactory_release_url']} is allowed"
                                remove repo
                            }
                        }
                        // add the enterprise repository
                        maven {
                            url System.properties['artifactory_release_url']
                            credentials {
                                username System.properties['artifactory_user']
                                password System.properties['artifactory_password']
                            }
                        }
                    }
                }
            }
        }
        gradle.projectsLoaded {
            rootProject.allprojects {
                buildscript {
                    repositories {
                        maven{
                            url System.properties['artifactory_release_url']
                            credentials {
                                username System.properties['artifactory_user']
                                password System.properties['artifactory_password']
                            }
                        }
                    }       
                }
                afterEvaluate { project ->
                    if ( project.plugins.hasPlugin( 'maven-publish' ) ) {
                        project.publishing.repositories {
                            // Remove all repositories not pointing to the enterprise repository url
                            all { ArtifactRepository repo ->
                                if (repo instanceof MavenArtifactRepository && !repo.url.toString().startsWith(System.properties['artifactory_release_url'])) {
                                    project.logger.lifecycle "Publishing Repository ${repo.url} removed. Only ${System.properties['artifactory_release_url']} is allowed"
                                    remove repo
                                }
                            }                
                            maven {
                                url System.properties['artifactory_release_url']
                                credentials {
                                    username System.properties['artifactory_user']
                                    password System.properties['artifactory_password']
                                }
                            }
                        }            
                    }
                }        
            }
        }
        
        gradle.settingsEvaluated { settings ->
            settings.pluginManagement {
        		repositories {
        			maven{
        				url System.properties['artifactory_release_url']
        				credentials {
        					username System.properties['artifactory_user']
        					password System.properties['artifactory_password']
        				}
        			}
        		} 
            }
        }

{% set source_url_pattern_old = "https://services.gradle.org/distributions/gradle-%s-bin.zip" %}
{% set source_url_pattern = "https://gradle.org/next-steps/?version=%s&format=bin" %}

{% set tar_path_gradle = "gradle-%s-bin.zip" %}
{% set bin_path_gradle = "gradle" %}
{% set base_path_gradle = "gradle-%s" %}

{% for version in salt['pillar.get']('gradle:versions', {}) %}

gradle-create-dir-{{ version }}:
    file.directory:
        - user: root
        - name: /usr/local/bin/{{ bin_path_gradle }}/{{ base_path_gradle|format( version ) }}
        - group: root
        - mode: 755
        - makedirs: True
        - unless: test -d /usr/local/bin/{{ bin_path_gradle }}/{{ base_path_gradle|format( version ) }}

gradle-download-{{ version }}:
  cmd.run:
    - name: "curl {{ source_url_pattern|format( version) }}"
    - unless: test -d /usr/local/bin/{{ bin_path_gradle }}/{{ base_path_gradle|format( version ) }}/bin

gradle-unzip-{{ version }}:
  cmd.run:
    - name: "sudo unzip -o -d /usr/local/bin/{{ bin_path_gradle }} /root/{{ tar_path_gradle|format( version ) }}"
    - unless: test -d /usr/local/bin/{{ bin_path_gradle }}/{{ base_path_gradle|format( version ) }}/bin

gradle-{{ version }}-alt-installed:
  alternatives.install:
      - name: gradle
      - link: /usr/bin/{{ bin_path_gradle }}
      - path: /usr/local/bin/{{ bin_path_gradle }}/{{ base_path_gradle|format( version ) }}/bin/{{ bin_path_gradle }}
      - priority: 100

gradle-{{ version }}-tar-remove:
  file.absent:
    - name: /root/{{ tar_path_gradle|format( version ) }}

{% endfor %}