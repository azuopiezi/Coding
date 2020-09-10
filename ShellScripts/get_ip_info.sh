#!/bin/bash
#/告诉使用者，这程序的用户是从ipconfig 命令中获取IP地址
echo "该程序是从命令中ifconfig中获取的IP地址："
#2、提示使用者，输入将要查询设备的名字
read -p "请输入想要查询IP的设备名字：(eth0/eth1/eth2/HELP):" Dev 
case ${Dev} in
	"HELP")
	echo "如果不知道您电脑设备号，可以通过命令/etc/udev/rules.d/70-persistent-net.rules 查看。"
	exit 1
	;;
	"")
	echo "请输入内容，如eth0/eth1/eth2/HELP"
	exit 1
	;;
	"eth0")
	ifconfig eth0 |grep 'inet' |awk 'NR==1{print}'| sed s/^.*addr://g | sed s/Bcast.*$//g
	exit 1
	;;
	"eth1")
	ifconfig eth1 |grep 'inet' | awk 'NR==1{print}'| sed s/^.*addr://g | sed s/Bcast.*$//g
	exit 1
	;;
	"eth2")
	ifconfig eth2 |grep 'inet' | awk 'NR==1{print}'|sed s/^.*addr://g |sed s/Bcast.*$//g
	;;
	*)
	echo "请输入正确的内容！"
	exit 1
	;;
ecac


	 
