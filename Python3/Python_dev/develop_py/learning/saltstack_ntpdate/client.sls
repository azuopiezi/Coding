ntpdate:
  pkg:
  - installed

#install ntpdate software bar

ntpdate-cmd:
  file.managed:
    - name: /var/sysmgmt/ntpdate-from-{{pillar['time_server_ip']}}.sh
    - source: salt://conf/ntpdate.sh
    - template: jinja
    - mode: 744
    - require:
      - file: sysmgmt-dir

##描述时间同步脚本状态信息

ntpdate-crond:
  cron.present:
    - name: /var/sysmgmt/ntpdate-from-{{pillar['time_server_ip']}}.sh
    - user: root
    - minute: random
    - hour: 0
    - require:
      - file: ntpdate-cmd

#定义系统cron定期同步系统时间

