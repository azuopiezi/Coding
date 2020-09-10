include:
  - nginx.install // 引用安装
{% set nginx_user = 'nginx' + '' + 'nginx' %} //设置用户变量
nginx_conf:
  file.managed:  // nginx 主配置文件管理
    - name: /usr/local/nginx/conf/nginx.conf
    - source: salt://nginx/files/nginx.conf
    - template: jinja
    - defaults:
      nginx_user: {{ nginx_user }}
      num_cpus: {{ grains['num_cpus']}} //根据cpu的个数来设置nginx.conf文件
nginx_service: //nginx服务管理
  file.managed:
    - name: /etc/init.d/nginx
    - user: root
    - mode: 755
    - source: salt://nginx/files/nginx
  cmd.run:  //将服务由chkconfig 管理
    - names:
      - /sbin/chkconfig --add nginx
      - /sbin/chkconfig nginx on
    - unless: /sbin/chkconfig --list nginx
  service.running:  //nginx 是启动状态
    - name: nginx
    - enable: True
    - reload: True
    - wacth:
      - file: /usr/local/nginx/conf/*.conf

nginx_log_cut: //nginx 日志管理
  file.managed:
    - name: /usr/local/nginx/sbin/nginx_log.cut.sh
    - source: salt://nginx/files/nginx_log_cut.sh
  cron.present:   //将日志切割脚本加入crontab定时执行
    - name: sh /usr/local/nginx/sbin/nginx_log_cut.sh
    - user: root
    - minute: 10
    - hour: 0
    - require:
      -file: nginx_log_cut

