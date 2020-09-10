#!/bin/bash
cat /mnt/tomcat_all/logs/catalina.out| grep activeurl | awk -F 'activeinfo=' {'print $2'}  > url.txt

for url in $(cat url.txt); do
  curl -d "activeinfo=$url&answer=1&confimpassword=aA111111&password=aA111111&question=1" "http://e.sur.com/activeUser"
done
