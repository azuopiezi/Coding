#! /bin/bash
#----要清理的日志路径，多路径以空格隔开---

selfpath=`dirname $0`
exec 1>>$selfpath/../log/clearlog.log 2>&1
filepath=($selfpath/../log/)
#----清理日志函数-------
function clearlog(){
echo -e "\e[1;32m 开始清理日志，超过200M的日志将被清理\e[0m"
echo -e "\e[1;32m 超过5天以上的日志将被清理\e[0m"
num=${#filepath[@]}
for((i=0;i<$num;i++))
do      
	echo "filepath="${filepath[$i]}
        for l in `find ${filepath[$i]} -name *.log -a -size +409600 -exec ls {} \;`
        do
        	echo $l
                echo -e "\c" > $l
        done
	find ${filepath[$i]} -mtime +5 -a -name "*.log" -exec ls {} \;
	find ${filepath[$i]} -mtime +5 -a -name "*.log" -exec rm -f {} \;
done
}

#------sleep 14400-----间隔4小时，清理一次-------
#while true
#do
	clearlog
#	sleep 2
#done
