#!/bin/bash

###################################33333333######3333
###file name :print picture.sh
###Author :sxwen
###creaed date: now
#usage() {
	#	cat << EOF
#EOF
#}

main()
{
	n=1
	for(( i=1;i<10;i++ ))
	do 
		for(( j=1;j<10;j++ ))
		do
			echo $((n++))  $j '*' $i = $((i*j));
		done
		echo " "	
	done	
	
	for((i=1;i<10;i++))
	do 
		for((j=10;j>i;j--))
		do
			echo -n "";
		done
		for((m=1;m<=i;m++))
		do
			echo -n $i;
		done
		echo ""
	done
}


main "$@"
exit 0