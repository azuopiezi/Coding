/etc/resolv.conf:
  file.managed:
    - source: salt://files/resolv.conf
    - user: root #root
    - group: root
    - mode: 644