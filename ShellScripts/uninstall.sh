#! /bin/sh

# 卸载脚本
# ---------------------------
# 1.恢复原来的host文件以及my.cnf（如果存在的话），limits.conf
# 2.停掉所有开启的java进程
# 3.删除目录
# 卸载中出现的任何问题需要做详细记录
# 如果有问题，请邮件联系xiaoyaguang@sursen.net

function killthread(){
	ps -ef|grep $1 |grep -v grep |awk '{print $2}'|xargs kill -9
}

service crond stop
echo "停止activemq服务"
killthread activemq
echo "停止异步更新服务"
killthread async-upd-consumer
echo "停止搜索服务"
killthread elasticsearch
echo "停止主键服务"
killthread sequenceserver
echo "停止zookeeper服务"
killthread zookeeper-surdoc
echo "停止tomcat服务"
killthread tomcat
killthread clearlog

cd ../
echo "停止riak服务..."
for i in {1..4}
do
	./riak-2.1.1/dev/dev$i/bin/riak stop
done
killthread riak

echo "查看是否还有java进程在"
ps -ef |grep java |grep -v grep
dstr=`ps -ef |grep java |grep -v grep|wc -l`
if [ $dstr -eq 0 ];then
	echo "所有java进程均已经停止"
else
	echo "仍然有进程存在，可能需要手动去杀掉这些进程"
fi

sleep 1

echo "停止memcached服务"
service memcached stop
service memcached status
echo "停止mysql实例"
mysqld_multi stop
sleep 2
mysqld_multi report

echo "恢复host文件以及my.cnf文件"
scp bak/hosts /etc/
scp bak/my.cnf /etc/


while true
do
	read -p "是否卸载memcache服务?[yes/no]:" str
	case $str in
		yes)
			rpm -e memcached-1.4.4-3.el6.x86_64 --nodeps
			echo "memcached 服务卸载完成"
			break
			;;
		no)
			break
			;;
		*)
			;;
	esac
done

while true
do
	read  -p "是否卸载mysql服务?[yes/no]:" str
	case $str in
		yes)
			rpm -e MySQL-devel-5.5.16-1.rhel4.x86_64 --nodeps
			rpm -e MySQL-server-5.5.16-1.rhel4.x86_64 --nodeps
			rpm -e MySQL-client-5.5.16-1.rhel4.x86_64  --nodeps
			rpm -e MySQL-shared-compat-5.5.29-2.el6.x86_64 --nodeps
			echo "mysql卸载完成"
			break
			;;
		no)
			break
			;;
		*)
			;;
	esac
done

while true
do
	read -p "是否卸载jdk?[yes/no]:" str
	case $str in
		yes)
			rpm -e jdk-1.7.0_60-fcs.x86_64 --nodeps
			echo "jdk-1.7.0_60-fcs.x86_64卸载完成"
			break;;
		no)
			break;;
		*)
			;;
	esac
done

scp install-rpm/mysql-libs-5.1.73-5.el6_7.1.x86_64.rpm ~/

echo "开始删除目录"
rm -rf activemq async-upd-consumer elasticsearch-1.5.2 install-rpm
rm -rf riak-2.1.1 sequenceserver tomcat_all zookeeper-surdoc
rm -rf das bak

echo "删除mysql数据库"
rm -rf ssd30
sed -i -c "/sh\/clearlog/d" /etc/crontab
sed -i -c "/sh\/keepalive/d" /etc/crontab
sed -i -c "sh\/modifyUserSize" /etc/crontab
service crond start
rm -rf sh log
echo "卸载完成"

echo -e "注意:\e[1;32m 有两个操作可能需要你手动去完成 \e[0m"
echo -e "1.在安装过程中可能卸载mysql-libs包，所以需要确认后并手动安装，我们已经将mysql-libs包放在了/root目录下，执行命令\n # rpm -ivh /root/mysql-libs-5.1.73-5.el6_7.1.x86_64.rpm\n来进行安装"
echo -e "2.named服务没有卸载,不确定之前有没有安装dns服务。如果需要卸载请手动执行卸载。"
echo -e "第一个如果没有安装产生的影响为：sendmail或者postfix服务不可用(如果你的机器需要邮件服务的话)。"
echo -e "\e[1;32m 存储目录不做删除动作 \e[0m"
#rm -f uninstall.sh
