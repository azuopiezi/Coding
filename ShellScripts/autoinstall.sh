#! /bin/sh

# 单机版云盘自动部署脚本内容：
# ---------------------------
# 1.安装jdk
# 2.安装mysql
# 3.安装memecached
# 4.启动搜索/主键/异步/zookeeper/mq服务
# 5.启动tomcat服务
# ---------------------------
# 
# 部署过程中出现任何问题，需要做详细记录。
# 如果出现问题，请发送邮件联系xiaoyaguang@sursen.net

#备份host以及my.cnf 和limits.conf文件，方便回滚

#更改句柄数限制
while true
do
	read  -p "请确认已经申请授权文件license.dat，并成功替换[yes/no]:" shouquan
	case $shouquan in
		yes) 
			break;;
		no)
			exit 0;;
		*)
			;;
	esac
done

while true
do
	read -p "请确认已经初始化存储目录[yes/no]:" storage
	case $storage in
		yes)
			break;;
		no)
			echo "请执行initStoreDir.sh初始化存储目录"
			exit 0;;
		*)
			;;
	esac
done

num=`ulimit -n`
if [ "$num" = "65536" ];then
	echo "句柄数限制为:$num"
else
	echo "句柄数限制为:$num，将自动为你需要修改为65536"
	echo "ulimit -n 65536" >> /etc/profile
	source /etc/profile
fi

cd ../
rpm -qa|grep perl
if [ $? -ne 0 ];then
	echo "发现机器缺少必要的perl模块，准备安装"
	rpm -ivh install-rpm/perl/*rpm
fi	


scp /etc/hosts bak/
scp /etc/my.cnf bak/

#停止防火墙
echo -e "\e[1;32m 开始进行单机版安装部署 \e[0m"
echo "关闭防火墙"
service iptables stop
chkconfig iptables off

#将selinux的值修改为disabled
sed -i "s/SELINUX=\(.*\)/SELINUX=disabled/g" /etc/selinux/config

#安装jdk，如果已经安装则不会重复安装
sleep 1
rpm -qa | grep jdk
str=`rpm -qa | grep jdk`
if [ -z $str ];then
	echo "机器上未安装jdk，开始进行安装"
	rpm -ivh install-rpm/jdk-7u60-linux-x64.rpm
	echo "jdk安装完成，版本号为："
	java -version
else
	echo "发现您的机器上好像已经安装了jdk，继续往下运行" 
fi
scp install-rpm/jar/* /usr/java/jdk1.7.0_60/jre/lib/security/
sleep 1

#安装mysql
#如果发现机器已经安装了mysql-libs，需要手动卸载，rpm -e mysql-libs --nodeps
echo "开始安装mysql"
mysqlpath=/usr/bin/mysql
if [ -f $mysqlpath ];then
	echo "机器上已经安装mysql，将跳过安装"
else
	echo "发现你的机器上安装了mysql的一些相关包，可能会在安装mysql时候产生冲突，请确认！"
	echo "--------------------------"
	rpm -qa |grep -i mysql
	echo "--------------------------"
	for l in `rpm -qa | grep -i mysql`
	do
		while true
		do
			read  -p "$l 请确认是否要卸载[yes/no]:" comm
			case $comm in
				yes)
					rpm -e $l --nodeps
					echo "$l 卸载完成"
					break
					;;
				no)
					break
					;;
				*)
					;;
			esac
		done
	done
	rpm -ivh install-rpm/mysql/*
	echo "mysql安装成功"
fi
sleep 2
service mysql stop
if [ -f /etc/my.cnf ];then
	mv /etc/my.cnf /etc/my.cnf.$RANDOM
fi
cp install-rpm/my.cnf /etc/
path=`pwd`
sed -i s:mnt:$path:g /etc/my.cnf
mysqld_multi start
sleep 4
mysqld_multi report

#安装邮件服务postfix或者sendmail的依赖库，因为在安装mysql的时候可能卸载了mysql-libs包
echo "安装邮件服务依赖的mysql-libs库"
rpm -ivh install-rpm/MySQL-shared-compat-5.5.29-2.el6.x86_64.rpm
mailstr=`rpm -qa |grep postfix`
if [ -z $mailstr ];then
	mailstr=`rpm -qa |grep sendmail`
		if [ "$mailstr" = "" ];then
			echo "机器上似乎没有安装邮件服务,尝试安装postfix"
			rpm -ivh install-rpm/postfix-2.6.6-6.el6_7.1.x86_64.rpm
		else
			service sendmail restart
		fi
else
	service postfix restart
fi
sleep 1

#安装memcached服务
rpm -qa | grep memcached
str=`rpm -qa | grep memcached`
if [ -z $str ];then
	echo "安装memcached"
	rpm -ivh install-rpm/libevent-1.4.13-4.el6.x86_64.rpm
	rpm -ivh install-rpm/memcached-1.4.4-3.el6.x86_64.rpm
	echo "memcached安装完成，启动服务"
	service memcached start
	chkconfig memcached on
	service memcached status
	echo "启动完毕"
else
	echo "发下已经安装memcached服务，重启一下服务"
	echo "service memcached restart"
	service memcached restart
	chkconfig memcached on
	service memcached status
fi
sleep 1

#修改host文件
cat install-rpm/hosts >> /etc/hosts
hostname=`hostname`
echo "127.0.0.1   ${hostname}">>/etc/hosts



echo "执行其他服务启动"
cd activemq/bin/
./activemq start
echo -e  "\e[1;32m activemq 服务启动 \e[0m"

cd ../../async-upd-consumer/bin/
./startup.sh
echo -e "\e[1;32m 异步更新服务启动 \e[0m"

cd ../../

#rm -rf elasticsearch-1.5.2/data/enterprisesearch/nodes
cd elasticsearch-1.5.2/bin/
./elasticsearch -d
echo -e "\e[1;32m 搜索服务启动 \e[0m"
#curl -XPUT -H 'Content-Type: application/json' -d '{"settings" : {"number_of_shards" : 1, "number_of_replicas" : 0},"mappings" : {"tindex" : {"dynamic" : "strict","_id" : {"path" : "uuid"},"_routing" : {"required" : true,"path" : "creator"},"properties" : {"uuid" : {"type" : "string","index": "not_analyzed"},"title" : {"type" : "string","index": "analyzed","index_analyzer": "index_ansj","search_analyzer": "query_ansj"},"type" : {"type" : "string","index": "no"},"id" : {"type" : "string","index": "no"},"isStar" : {"type" : "string","index": "not_analyzed"},"creator" : {"type" : "string","index": "not_analyzed"}}}}}' http://127.0.0.1:9200/surdoc

cd ../../sequenceserver/
./start.sh
echo -e  "\e[1;32m 主键服务启动 \e[0m"


cd ../zookeeper-surdoc/bin
./zkServer.sh start
echo -e "\e[1;32m zookeeper 服务启动 \e[0m"

#riak服务启动。注释内容，可以用来重新手动配置riak服务，组建riak集群，初始化riak服务
cd ../../
echo "正在启动riak，请稍后....."
for i in {1..4};do ./riak-2.1.1/dev/dev$i/bin/riak start;done
#for i in {1..3};do ./riak-2.1.1/dev/dev$i/bin/riak-admin cluster join dev4@127.0.0.1;done
#./riak-2.1.1/dev/dev4/bin/riak-admin cluster plan
#./riak-2.1.1/dev/dev4/bin/riak-admin cluster commit
./riak-2.1.1/dev/dev4/bin/riak-admin member-status
#tmp=0
#str=
#while true
#do 
#	for i in `./riak-2.1.1/dev/dev4/bin/riak-admin member-status`
#		do
#			tmp=$(($tmp+1))
#			if [ $tmp = "10" ];then
#				str=$i
#			fi
#		done
#if [ $str = "25.0%" ];then
#	echo $str
#	break
#fi
#tmp=0			
#done
#curl -XPUT -H "Content-Type: application/json" -d '{"props":{"allow_mult":true}}' http://127.0.0.1:10018/riak/security.digestBucket
#curl -XPUT -H "Content-Type: application/json" -d '{"props":{"allow_mult":true}}' http://127.0.0.1:10018/riak/security.digestBucket2


#加入定时任务
service crond stop
installpath=`pwd`
donum=`grep keepalive.sh /etc/crontab|wc -l`
if [ $donum -eq 0 ];then
	echo "*/2 * * * * root /bin/bash $installpath/sh/keepalive.sh">>/etc/crontab
fi
donum=`grep clearlog.sh /etc/crontab|wc -l`
if [ $donum -eq 0 ];then
	echo "*/59 * * * * root /bin/bash $installpath/sh/clearlog.sh">>/etc/crontab
fi
donum=`grep modifyUserSize.sh /etc/crontab |wc -l`
if [ $donum -eq 0 ];then
	echo "* * * * */5 root /bin/bash $installpath/sh/modifyUserSize.sh -all" >>/etc/crontab
fi

#echo ""
#echo ""
#while true
#do
#	read -p "直接开启tomcat服务?[yes/no]:" comm
#	case $comm in
#	yes)
#		break;;
#	no)
#		echo "程序退出，稍后您可以手动启动tomcat服务"
#		exit 0
#		;;
#	*)
#		;;
#	esac
#done

sleep 2
cd tomcat_all/bin/
sh startup.sh

cd ../../
service named status
if [ $? -ne 0 ];then
	echo -e "\e[1;32m 安装dns服务 \e[0m"
	rpm -ivh install-rpm/bind/portreserve-0.0.4-11.el6.x86_64.rpm
	rpm -ivh install-rpm/bind/bind-libs-9.8.2-0.47.rc1.el6.x86_64.rpm
	rpm -ivh install-rpm/bind/bind-9.8.2-0.47.rc1.el6.x86_64.rpm
else
	echo -e "\e[1;32m dns服务已安装\[0m"
fi

#---- 安装dns服务----
echo "替换dns的解析文件"
service named stop
while true
do
        read -p "请输入本机IP地址：" ip
        echo $ip |grep -E "^[0-9]*\\.[0-9]*\\.[0-9]*\\.[0-9]*$"
        if [ $? -ne 0 ];then
                echo "请正确输入ip地址(0.0.0.0)"
        else
                break
        fi
done
scp install-rpm/bind/sur.com.zone /var/named/
chown named.named /var/named/sur.com.zone
sed -i "s/IP/$ip/g" /var/named/sur.com.zone

if [ -f /etc/named.conf ];then
	cp /etc/named.conf /etc/named.conf.$RANDOM
fi
cat install-rpm/bind/named.conf >/etc/named.conf
chown root.named /etc/named.conf

chattr -i /etc/resolv.conf
cp /etc/resolv.conf /etc/resolv.conf.$RANDOM
echo "search sur.com" > /etc/resolv.conf
echo "nameserver $ip" >> /etc/resolv.conf
chattr +i /etc/resolv.conf
service named start

#开启定时任务
service crond start

#检查部署的服务是否正常
cd sh/
./doServer.sh all status

echo -e "\e[1;32m 部署已经完成，正在启动tomcat服务。。。 \e[0m"
echo -e "\e[1;32m 如有服务仍未启动，请执行./doServer.sh {cmd} start启动相关服务  \e[0m"
sleep 3
cd ../tomcat_all/logs
tail -f catalina.out
