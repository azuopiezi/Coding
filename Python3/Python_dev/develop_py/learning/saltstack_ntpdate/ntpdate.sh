/!bin/bash
/usr/sbin/ntpdate{{pillar['time_server_ip'}} > /dev/null
/sbin/clock -w > /dev/null