#!/bin/bash
read -p "press some key, then press return:" KEY
case $KEY in
	[a-z]|[A-Z])
	echo "it is a letter"
	exit 1
	;;
	[0-9])
	echo "it is a digit"
	exit 1
	;;
	*)
	echo "it is function keys,Spacebar or other keys."
	exit 1
	;;	
esac