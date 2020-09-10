#nginx.tar.gz
nginx_source:
  file.managed:
    - name: /tmp/nginx-1.8.0.tar.gz
    - unless: test -e /tmp/nginx-1.8.0.tar.gz
    - source: salt://nginx/files/nginx-1.8.0.tar.gz

#extract

extract_nginx:
  cmd.run:
    - cwd: /tmp
    - names:
        - tar zxvf nginx-1.8.0.tar.gz
    - unless: test -d /tmp/nginx_1.8.0
    -require:
        - file: nginx_source

#user

nginx_user:
  user.present:
    - name: nginx
    - uid: 1501
    - createhome: False
    - gid_from_name: True
    - shell: /sbin/nologin

#nginx_pkgs

nginx_pkg:
  pkg.installed:
    - pkgs:
        - gcc
        - openssl-devel
        - pcre-devel
        - zlib-devel

# nginx_compile

nginx_compile:
  cmd.run:
    - cwd: /tmp/nginx-1.8.0
    - names:
      - ./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module --with-http_gzip_static_module \
      --http-client-body-temp-path=/usr/local/nginx/client/ --http-proxy-temp-path=/usr/local/nginx/proxy/ --http-fastcgi-temp-path=/usr/local/nginx/fcgi \
      --with-poll_module --with-file-aio --with-http_realip_module --with-http_addition_module --with-http_random_index_module \
      --with-pcre --with-http_stub_status_module
      - make
      - make install
    - require:
      - cmd.run: extract_nginx
      - pkg: nginx_pkg
    - unless: test-d /usr/local/nginx

#cache_dir

cache_dir:
  cmd.run:
    - names:
      - mkdir -p /usr/local/nginx/{client,proxy,fcgi} && chown -R nginx.nginx /usr/local/nginx/
    - unless: test -d /usr/local/nginx/client/
    - require:
      - cmd.run: nginx_compile


