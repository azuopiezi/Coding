#!/bin/bash
ansible-doc 相当于man help
ansible-doc --help
Usage: ansible-doc [options] [module...]

Options:
  -h, --help            show this help message and exit
  # shellcheck disable=SC2215
  -l, --list            List available modules
  -M MODULE_PATH, --module-path=MODULE_PATH
                        specify path(s) to module library (default=None)
  -s, --snippet         Show playbook snippet for specified module(s)
  -v, --verbose         verbose mode (-vvv for more, -vvvv to enable
                        connection debugging)
  --version             show program's version number and exit'
这个工具非常有用

# ansible host 支持逻辑符来匹配不同的设置
ansible 的Host-pattern
All: 表示所有Inventory 中的所有主机
ansible all -m ping

*:通配符
ansible "*" -m ping
ansible 192.168.1.* -m ping
ansible "*server" -m ping
或关系
ansible "websrvs:appsrvs" -m ping
ansible "192.168.1.10:192.168.2.20" -m ping

逻辑与 ansible "websrvs:&dbsrvs" -m ping
逻辑非 ansible "websrvs:!dbsrvs" -m ping
综合逻辑 ansible "websrvs:dbsrvs:&appsrvs:!ftpsrvs" -m ping
正则表达式 "~(web|db).*\.magedu\.com" -m ping

##ansible-galaxy
连接https://galaxy.ansible.com 下载相应的roles
ansible-galaxy list
安装galaxy
ansible-galaxy install geerlingguy.nginx


[root@ansible ~]# ansible-galaxy install geerlingguy.nginx
- downloading role 'nginx', owned by geerlingguy
- downloading role from https://github.com/geerlingguy/ansible-role-nginx/archive/2.8.0.tar.gz
- extracting geerlingguy.nginx to /etc/ansible/roles/geerlingguy.nginx
- geerlingguy.nginx was installed successfully
[root@ansible ~]# cd /etc/ansible/roles/
[root@ansible roles]# ls
geerlingguy.nginx
[root@ansible roles]# cd geerlingguy.nginx/
[root@ansible geerlingguy.nginx]# ls
defaults  handlers  LICENSE  meta  molecule  README.md  tasks  templates  vars
[root@ansible geerlingguy.nginx]# tree .
.
├── defaults
│   └── main.yml
├── handlers
│   └── main.yml
├── LICENSE
├── meta
│   └── main.yml
├── molecule
│   └── default
│       ├── converge.yml
│       └── molecule.yml
├── README.md
├── tasks
│   ├── main.yml
│   ├── setup-Archlinux.yml
│   ├── setup-Debian.yml
│   ├── setup-FreeBSD.yml
│   ├── setup-OpenBSD.yml
│   ├── setup-RedHat.yml
│   ├── setup-Ubuntu.yml
│   └── vhosts.yml
├── templates
│   ├── nginx.conf.j2
│   ├── nginx.repo.j2
│   └── vhost.j2
└── vars
    ├── Archlinux.yml
    ├── Debian.yml
    ├── FreeBSD.yml
    ├── OpenBSD.yml
    └── RedHat.yml

8 directories, 23 files
[root@ansible geerlingguy.nginx]#
删除
[root@ansible ~]# ansible-galaxy remove geerlingguy.nginx
- successfully removed geerlingguy.nginx
[root@ansible ~]#

执行 playbook 时 如果命令或者脚本的退出码不为零，可以使用如下方式替代
tasks:
  - name: run this command and ignore the resule
    shell: /usr/bin/somecommand || /bin/true
或者使用ignore_errors 来忽略错误信息：
tasks:
  - name: run this command and ignore the resule
    shell: /usr/bin/somecommand
    ignore_errors: True

handlers 和notify 结合使用触发条件
Handlers
是task列表，这些task与前述的task并没有本质上的不同，用于当关注的资源发生变化时，才会采取一定的操作
Notify此action可用于在每个play的最后被触发，这样可避免多次有改变发生时每次都执行指定的操作，
仅在所有的变化发生完成后一次性的执行指定操作。在notify中列出的操作称为handler，也即notify中调用handler中定义的操作
"
- hosts: websrvs
  remote_user: root
  tasks:
    - name: install httpd package
      yum: name=httpd
    - name: copy conf file
      copy: scr=files/httpd.conf dest=/etc/httpd/conf backup=yes
      notify: restart service
    - name: start service
      service: name=httpd state=started enable=yes
  handlers:
    - name: restart service
      service: name=httpd state=restarted

##备注 notify 可以出发多个action
ansible-playbook -c +xxx.yml 文件用来检查语法是否正确
"
在脚本中可以使用tags 标签 来指定某个动作执行
ansible-playbook -t tags1，tags2 httpd.yml

