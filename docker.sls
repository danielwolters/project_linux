docker installeren:
  pkg.installed:
    - name: docker.io

hello-world container:
  cmd.run:
    - name: 'docker run  hello-world'
    - runas: root
