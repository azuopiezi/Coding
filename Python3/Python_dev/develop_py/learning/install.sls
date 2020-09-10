include:
  - init.pkg
  - init.www
lua-nginx-module-install:
  file.managed:
    - name: /usr/local/src/lua-nginx-module-0.9.10.tar.gz
    - source: salt://nginx/file/lua-nginx-module-0.9.10.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf lua-nginx-module-0.9.10.tar.gz
    - unless: test -d /usr/local/src/lua-nginx-module-0.9.10








