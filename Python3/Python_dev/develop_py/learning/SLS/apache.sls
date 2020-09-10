apache-install: #ID 声明,容易理解知道下面写的是什么,名字必须唯一.
  pkg.installed:  #两个空格缩进代表层级关系,pkg是一个模块,installed 是一种方法
    - names:  #短横线代表列表,冒号和两个空格缩进代表层级关系
      - httpd # 短横线后面必须要有空格
      - httpd-devel


apache-service:
  service.running:
     - name: httpd
     - enable: True
     - reload: True