#! /bin/bash
#---------------
#check all servers' status
#stop single/all server
#start single/all server
#restart singl/alle server
#connection-email xiaoyaguang@sursen.net
#---------------
source /etc/profile

selfpath=`dirname $0`
function checkserver(){
        num=`ps -ef|grep $1 |grep -v grep|grep -v doServer |wc -l`
        if [ $num -eq 0 ];then
                echo -e "\e[1;32m $1\e[0m\e[1;31m\t\t服务未运行 \e[0m"
        elif [ $num -eq 1 ];then
                echo -e "\e[1;32m $1\e[0m\e[1;32m\t\t服务运行正常 \e[0m"
        else
                echo -e "\e[1;32m $1\e[0m\e[1;31m\t\t服务重复启动 \e[0m"
        fi
}
function telstatus(){
        num=`ps -ef|grep $1 |grep -v grep|grep -v doServer |wc -l`
        if [ $num -eq 0 ];then
                echo -e "\e[1;32m $1\e[0m\e[1;31m\t\t服务停止 \e[0m"
        elif [ $num -eq 1 ];then
                echo -e "\e[1;32m $1\e[0m\e[1;32m\t\t服务启动成功 \e[0m"
        else
                echo -e "\e[1;32m $1\e[0m\e[1;31m\t\t服务重复启动 \e[0m"
        fi
}
function stopServer(){
	ps -ef|grep $1 |grep -v grep|grep -v doServer | awk {'print $2'}|xargs kill -9
}
if [ $# -ne 2 ];then
	printf "Usage: $0 {all|activemq|sequence|zookeeper|async|search|tomcat|memcached|riak|mysql} [status|start|stop|restart]\n"
	exit 0
else
	server=$1
	opeartion=$2
	case $2 in
		"status")
			case $1 in
				"all")
					echo -e "\e[1;36m=================================服务运行状况=================================\e[0m"
					checkserver activemq
					checkserver sequenceserver
					checkserver zookeeper
					checkserver async-upd-consumer
					checkserver elasticsearch
					checkserver tomcat 
					echo -e "\e[1;34m查询riak运行状态\e[0m"
					$selfpath/../riak-2.1.1/dev/dev1/bin/riak-admin member-status
					echo -e "\e[1;34m查看数据库运行状态\e[0m"
					mysqld_multi report
					echo -e "\e[1;34m查看memcached服务运行状态\e[0m"
					service memcached status
					;;
				"activemq")
					checkserver activemq
					;;
				"sequence")
					checkserver sequenceserver
					;;
				"zookeeper")
					checkserver zookeeper
					;;
				"async")
					checkserver async-upd-consumer
					;;
				"search")
					checkserver elasticsearch
					;;
				"tomcat")
					checkserver tomcat
					;;
				"memcached")
					echo -e "\e[1;34m查询memcached运行状态\e[0m"
					service memcached status
					;;
				"riak")
					echo -e "\e[1;34m查询riak运行状态\e[0m"
                                        $selfpath/../riak-2.1.1/dev/dev1/bin/riak-admin member-status
					;;
				"mysql")
					echo -e "\e[1;34m查询mysql运行状态\e[0m"
					mysqld_multi report
					;;
				*)
					printf "Usage: $0 {all|activemq|sequence|zookeeper|async|search|tomcat|memcached|riak|mysql} [status|start|stop|restart]\n"
				        exit 0
					;;
			esac
			;;
		"stop")
			case $1 in
				"activemq")
					stopServer activemq
					telstatus activemq;;
				"sequence")
					stopServer sequenceserver
					telstatus sequenceserver;;
				"zookeeper")
					stopServer zookeeper
					telstatus zookeeper;;
				"async")
					stopServer async-upd-consumer
					telstatus async-upd-consumer;;
				"search")
					stopServer elasticsearch
					telstatus search;;
				"tomcat")
					stopServer tomcat
					telstatus tomcat;;
				"memcached")
					service memcached stop
					;;
				"riak")
					echo -e "\e[1;32m riak服务正在停止\e[0m"
					for i in {1..4}
					do
						$selfpath/../riak-2.1.1/dev/dev$i/bin/riak stop
					done
					echo -e "\e[1;32m riak服务停止成功\e[0m"
					;;
				"mysql")
					echo -e "\e[1;32m mysql服务停止\e[0m"
					mysqld_multi stop
					;;
				"all")
					$0 tomcat stop
					$0 sequence stop
					$0 search stop
					$0 zookeeper stop
					$0 async stop
					$0 memcached stop
					$0 activemq stop
					$0 riak stop
					$0 mysql stop
					;;
				*)
                                        printf "Usage: $0 {all|activemq|sequence|zookeeper|async|search|tomcat|memcached|riak|mysql} [status|start|stop|restart]\n"
                                        exit 0
                                        ;;

			esac
			;;
		"start")
			case $1 in
				"activemq")
					cd $selfpath/../activemq/bin/
					./activemq start
					telstatus activemq;;
				"sequence")
					cd $selfpath/../sequenceserver/
					./start.sh
					telstatus sequenceserver;;
				"zookeeper")
					cd $selfpath/../zookeeper-surdoc/bin/
					rm -f ./tmp/zookeeper_server.pid
					./zkServer.sh start
					telstatus zookeeper;;
				"async")
					cd $selfpath/../async-upd-consumer/bin/
					./startup.sh
					telstatus async-upd-consumer;;
				"search")
					cd $selfpath/../elasticsearch-1.5.2/bin/
					./elasticsearch -d
					telstatus search;;
				"tomcat")
					cd $selfpath/../tomcat_all/bin/
					sh startup.sh
					telstatus tomcat;;
				"memcached")
					service memcached start
					service memcached status
					;;
				"riak")
					echo -e "\e[1;32m riak正在启动\e[0m"
					for i in {1..4}
					do
						$selfpath/../riak-2.1.1/dev/dev$i/bin/riak start
					done
					$selfpath/../riak-2.1.1/dev/dev1/bin/riak-admin member-status
					echo -e "\e[1;32m riak服务启动完毕\e[0m"
					;;
				"mysql")
					mysqld_multi start
					sleep 3
					mysqld_multi report
					;;
				"all")
					$0 mysql start
					$0 memcached start
					$0 riak start
					$0 activemq start
					$0 sequence start
					$0 zookeeper start
					$0 async start
					$0 search start
					$0 tomcat start
                                        ;;
				*)
                                        printf "Usage: $0 {all|activemq|sequence|zookeeper|async|search|tomcat|memcached|riak|mysql} [status|start|stop|restart]\n"
                                        exit 0
                                        ;;
			esac
			;;
		"restart")
			case $1 in 
				"activemq")
					$0 activemq stop
					sleep 1
					$0 activemq start;;
				"sequence")
					$0 sequence stop
					sleep 1
					$0 sequence start;;
				"zookeeper")
					$0 zookeeper stop
					sleep 1
					$0 zookeeper start;;
				"async")
					$0 async stop
					sleep 1
					$0 async start;;
				"search")
					$0 search stop
					sleep 1
					$0 search start;;
				"tomcat")
					$0 tomcat stop
					sleep 1
					$0 tomcat start;;
				"memcached")
					$0 memcached stop
					sleep 1
					$0 memcached start;;
				"riak")
					$0 riak stop
					sleep 2
					$0 riak start;;
				"mysql")
					$0 mysql stop
					sleep 2
					$0 mysql start;;
				"all")
					$0 all stop
					sleep 3
					$0 all start;;
				*)
                                        printf "Usage: $0 {all|activemq|sequence|zookeeper|async|search|tomcat|memcached|riak|mysql} [status|start|stop|restart]\n"
                                        exit 0
                                        ;;
			esac
			;;
			
		*)
		printf "Usage: $0 {all|activemq|sequence|zookeeper|async|search|tomcat|memcached|riak|mysql} [status|start|stop|restart]\n"
                exit 0
                ;;
	esac
fi

