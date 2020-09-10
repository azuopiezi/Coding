#!/usr/bin/env bash
#!/bin/bash
###this script print ip and network
file="/etc/sysconfig/network-scripts/ifcfg-eth0"
if [ -f $file ];then
    IP= `grep "IPADDR" $file|awk -F "=" '{print $2}'`
    MASK=`grep "NETMASK" $file|awk -F "=" '{print $2}'`
    echo "$IP/$MASK"
   exit 1
fi




##!/bin/bash
#this prigram will printf ip/network
#
#IP =  `ifconfig eth0 |grep 'inet' |sed 's/^.*addr://g'|sed 's/Bcash.*$//g'|head -1`
#NETMASK = `ifconfig eth0 |grep 'inet' |sed 's/^.*Mask://g' |head -1`
#echo "$IP/$NETMASK"
#exit