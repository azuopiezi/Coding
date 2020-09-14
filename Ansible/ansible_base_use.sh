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

playbook 中变量使用
变量名：仅能由字符、数字和下划线组成，且只能以字符开头
变量来源：
 1.ansible setup facts 远程主机的所有变量都可以直接调用
 2.在/etc/ansible/hosts 中定义
 普通变量：主机组中主机单独定义，优先级高于公共变量
 公共(组)变量：针对主机组中所有主机定义统一变量


"
#hosts 中引用变量
all:
  hosts:
    node1:
      ansible_connection: ssh
      ansible_host: 10.100.201.161
      ansible_ssh_pass: Huayun@123
      ansible_ssh_user: root
      http_port: 80

    node2:
      ansible_connection: ssh
      ansible_host: 10.100.201.162
      ansible_ssh_pass: Huayun@123
      ansible_ssh_user: root
      http_port: 81
  children:
    hosts:
      node1:
      node2:
"
变量是http_port 在脚本中引用
"
#change.yml
---
- hosts: node1

  tasks:
    - name: set hostname
      hostname: name=www{{ http_port }}.test.com
"
执行脚本 查看是否引用完成
"
[root@ansible ansible]# ansible-playbook change.yml

PLAY [node1] *******************************************************************

TASK [setup] *******************************************************************
ok: [node1]

TASK [set hostname] ************************************************************
changed: [node1]

PLAY RECAP *********************************************************************
node1                      : ok=2    changed=1    unreachable=0    failed=0

[root@ansible ansible]# ansible node1 -m shell -a "hostnamectl"
node1 | SUCCESS | rc=0 >>
   Static hostname: www80.test.com
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 91b7f0cb876448cb976ffe4c3c2baedd
           Boot ID: e653734b65d54c1d8f8cd2297be7892d
    Virtualization: vmware
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-862.el7.x86_64
      Architecture: x86-64
"
 3.通过命令行指定变量，优先级最高
  ansible-playbook --e varname=value



"
ansible all -m setup  #输出远程主机中的变量
查看某一个变量信息可以使用filter 过滤出来
[root@ansible ~]# ansible all -m setup -a "filter=ansible_hostname"
node2 | SUCCESS => {
    "ansible_facts": {
        "ansible_hostname": "bbs"
    },
    "changed": false
}
node1 | SUCCESS => {
    "ansible_facts": {
        "ansible_hostname": "bbs"
    },
    "changed": false
}
"
对变量赋值 可以在执行语句时 直接-e 后面跟上变量名=值名 进行
ansible-playbook -e "var1=value1" xxx.yml
比如：
"
---
- hosts: appname
  remote_user: root

  tasks:
    - name: install paakage
      yum: name={{ var1 }}
    - name: start service
      service: name={{ var1 }} state=started enalbed=yes

ansible-playbook -e "var1=value1" xx.yml
"

 4.在playbook中定义
    vars:
    - var1：value1
    - var2: value2
"
  ---
- hosts: appname
  remote_user: root
  vars:
    - var1: httpd
  tasks:
    - name: install paakage
      yum: name={{ var1 }}
    - name: start service
      service: name={{ var1 }} state=started enalbed=yes

ansible-playbook xxx.yml
"
  5.在role中定义