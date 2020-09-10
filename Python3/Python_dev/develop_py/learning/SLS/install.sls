include:
  - pkg-init  ##单独写到一块,直接include 进来,一些环境安全包

haproxy-install:
  file.managed:
    - name: /usr/local/src/haproxy-1.6.5.tar.gz   ###文件haproxy-1.6.5.tar.gz放置在minion位置
    - source: salt://haproxy/files/haproxy-1.6.5.tar.gz  ####源文件放置位置
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf haproxy-1.6.5.tar.gz && cd haproxy-1.6.5 && make TARGET=linux26 PREFIX=/usr/local/haproxy && make install PREFIX=/usr/local/haproxy
    - unless: test -d /usr/local/haproxy ##如果有了就不安装,用unless: 如果是false 就执行
    - require: #依赖上面的gcc 状态,如果上面没有装上就不往下走了,同样文件没放过去就不执行下面的安装
      - pkg: pkg-init
      - file: haproxy-install
haproxy-config-dir:
  file.managed:
    - name: /etc/init.d/haproxy  ###启动脚本编辑
    - source: salt://haproxy/files/haproxy.init
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: haproxy-install     #如果没有安装就不要启动了
  cmd.run:
    - name: chkconfig --add haproxy
    - unless: chkconfig --list|grep haproxy
    - require:
      - file: haproxy-init   ###如果没有启动就不要加入到开机自启动了

net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1
# 负载均衡需要修改下面的监听IP,不然它如果检测不到VIP就会报错,需要改为1

