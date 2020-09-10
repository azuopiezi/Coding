#!/bin/bash
read -p "小明，你喜欢我吗？(喜欢|不喜欢|爱你):" love
case $love in
	xihuan)
	echo "wo ye xihuan ni !"
	exit 1
	;;
	buxihuan)
	echo "na ni xihuan shui?" who
	case $who in 
		xiaohong)
		echo "tashi wo guimi"
		exit 1
		;;
		xiaopeng)
		echo "e baibai"
		exit 1
		;;
		*)
		echo "womenbuheshi "
		;;
	esac
	;;
	*)
	echo "你到底啥意思"
	;;
esac
