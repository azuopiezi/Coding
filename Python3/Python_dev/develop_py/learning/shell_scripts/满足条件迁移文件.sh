#!/usr/bin/env bash
#!/bin/bash
for file in `ls /root`
do
    if [-f $file];then
        if [`ls -l $file|awk '{print $5}'` -gt 10000];then
             mv $file /tmp/
        fi
   fi

done

#mysqldump -u root -p test > test.sql
#mysql -u root -p test < test.sql

