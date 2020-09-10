#!/usr/bin/env bash
#!/bin/bash
i = 1
while [i -le 50]
    do
        if [-d /userdata];then
            mkdir -p -m 754 /usrdata/user$i
            echo "user$i"
            let "i = i + 1"
            else
            mkdir /usrdata
            mkdir -p -m /userdata/user$i
            echo "user$i"
            let "i = i +1"
            fi
    done
