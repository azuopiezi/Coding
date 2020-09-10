#!/bin/bash
##相互嵌套
read -p "果果，告诉妈妈今天想吃什么呀？  (香蕉|苹果|橘子|不想吃):" eat
case $eat in
	香蕉|苹果|橘子)
	echo "妈妈，我想吃$eat!"
	exit 1
	;;
	不想吃)
	read -p "那你想喝什么呀？(酸奶|白开水|纯奶|瓶瓶):" drink
	case $drink in
		酸奶|白开水|纯奶|瓶瓶)
		echo "妈妈，我想喝$drink!"
		exit 1
		;;
	esac
	;;
	*)
	echo "果果，那你到底想干什么呀，可不可以告诉妈妈呀？"
	exit 1
	;;
esac

	
	