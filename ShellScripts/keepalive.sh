#!/bin/bash

source /etc/profile
selfpath=`dirname $0`

exec 1>>$selfpath/../log/alive.log 2>&1



function checkserver(){
        num=`ps -ef|grep $1 |grep -v grep|grep -v doServer|grep -v tail |wc -l`
        if [ $num -eq 0 ];then
                echo -e "\e[1;32m $1\e[0m\e[1;31m\t\t服务未运行 \e[0m"
		return 1
        elif [ $num -eq 1 ];then
                echo -e "\e[1;32m $1\e[0m\e[1;32m\t\t服务运行正常 \e[0m"
		return 0
        else
                echo -e "\e[1;32m $1\e[0m\e[1;31m\t\t服务重复启动 \e[0m"
		return 3
        fi
}
function keepalive(){
	checkserver $1
	if [ $? -ne 0 ];then
        	$selfpath/doServer.sh $2 restart
	fi
}

date

#每次查看一下主机名，防止主机名更改影响服务
hostname=`hostname`
chattr -i /etc/hosts
grep $hostname /etc/hosts
if [ $? -ne 0 ];then
	echo "127.0.0.1 $hostname">>/etc/hosts
fi


service memcached status
if [ $? -ne 0 ];then
        service memcached restart
else
	echo "memcached service OK!"
fi

mysqldnum=`ps -ef|grep mysqld|grep port|grep -v grep |wc -l`
echo "mysqldnum=$mysqldnum"
if [ $mysqldnum -eq 4 ];then
	echo "mysql service OK!"
else
	mysqld_multi stop
	mysqld_multi start
fi

keepalive activemq activemq
keepalive sequenceserver sequence
keepalive zookeeper zookeeper
keepalive async-upd-consumer async
keepalive elasticsearch search
keepalive tomcat tomcat

for i in {1..4}
do
	$selfpath/../riak-2.1.1/dev/dev$i/bin/riak ping
	if [ $? -ne 0 ];then
		$selfpath/../riak-2.1.1/dev/dev$i/bin/riak start
	fi
done
