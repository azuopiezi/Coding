#!/bin/bash
# ------------------
# revise the usedsize of the user
# you should add the email that you want to revise
# please connect to xiaoyaguang if you have any problem
# ------------------

## -----------
# modify user's used_spaces
## -----------
function modifyUserUseSpace(){
	email=$1
	echo "email="$email
	roleidsql="select roleid from webdocbase.users where email = '$email'"
	roleid=`mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33331 -e "${roleidsql}" |grep -v roleid`
	sumSizeSql="select sum(srcFileSize) useSize from sep2server.TDoc where creator='$roleid' and delStatus=0"
	sumUseSize=`mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33331 -e "${sumSizeSql}"|grep -v useSize`
	if [ $sumUseSize = 'NULL' ];then
		sumUseSize=0
	fi
	modifyUserUseSpaceSql="update enterprisecloud.sursen_entc_user set used_spaces='$sumUseSize' where email = '$email'"
	echo $modifyUserUseSpaceSql
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${modifyUserUseSpaceSql}"
	
}

# /***************
# /* count dir sum size
# /***************
function countDirSize(){
	dirId=$1
	echo $dirId>dirid
	echo $dirId>totaldirid
	while true
	do
        	for i in `cat dirid`
        	do
                       	sqlstrstr="select dirid from sep2server.TDirectory where parentid='$i' and delStatus=0"
                      	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33331 -e "${sqlstrstr}"|grep -v dirid>>dirid
                       	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33331 -e "${sqlstrstr}"|grep -v dirid>>totaldirid
			sed -i "/$i/d" dirid
        	done
        	if [ ! -s dirid ];then
                	break
        	fi
	done
	sumSize=0
	for l in `cat totaldirid`
	do
		filesizesql="select sum(srcFileSize) filesize from sep2server.TDoc where dirid='$l' and delStatus=0"
		tempSumSize=`mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33331 -e "${filesizesql}"|grep -v filesize`
		if [ $tempSumSize = 'NULL' ];then
			tempSumSize=0
		fi
		sumSize=$(($sumSize+$tempSumSize))
	done
	rm -f dirid totaldirid
#	echo $dirId" sumSize:"$sumSize
	echo $sumSize
}

# /**
# *modify User Recycle Bin Spaces
# *
# */
function modifyUserRecyclebinSpace(){
	email=$1
	recycleDirIdSql="select recycle_bin_id id from enterprisecloud.sursen_entc_user where email = '$email'"
	recycleDirId=`mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${recycleDirIdSql}" |grep -v id`
	recycleDirUseSize=`countDirSize $recycleDirId`
	echo $recycleDirId "sumSize:" $recycleDirUseSize
	updateSql="update enterprisecloud.sursen_entc_user set recyclebin_used_spaces='$recycleDirUseSize' where email='$email'"
	echo $updateSql
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updateSql}"
}

#/***********
# modify sharefolder use_space
#/***********
function modifyShareFolderUseSpace(){
	getSharefolderSql="select folder_id id from enterprisecloud.sursen_entc_share_folder"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${getSharefolderSql}"|grep -v id >sharefolderid
	for i in `cat sharefolderid`
	do
		sumSize=`countDirSize $i`
		echo $i "sumSize:"$sumSize
		updateSql="update enterprisecloud.sursen_entc_share_folder set used_spaces='$sumSize' where folder_id = '$i'"
		echo $updateSql
		mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updateSql}"
	done
	rm -f sharefolderid
}

#/**************
# modify sharefolder recyclebin use_space
#/***************
function modifyShareFolderRBUS(){
	getSharefolderRBSql="select recyclebin_id id from enterprisecloud.sursen_entc_share_folder"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${getSharefolderRBSql}" |grep -v id > sharefolderRBid
	for i in `cat sharefolderRBid`
	do
		sumSize=`countDirSize $i`
		echo $i "sumSize:"$sumSize
		updateSql="update enterprisecloud.sursen_entc_share_folder set recyclebin_used_spaces='$sumSize' where recyclebin_id='$i'"
		echo $updateSql
		mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updateSql}"
	done
	rm -f sharefolderRBid
}

#/**************
# update admin use space
#/**************
function modifyAdminUseSpace(){
	sumSql="select sum(srcFileSize) filesize from sep2server.TDoc where delStatus=0"
	sumSize=`mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33331 -e "${sumSql}" |grep -v filesize`
	if [ $sumSize = 'NULL' ];then
		sumSize=0
	fi
	updateSql="update enterprisecloud.sursen_entc_enterprise set used_spaces='$sumSize'"
	echo $updateSql
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updateSql}"
}

#--->interface----
#modifyUserUseSpace
#CountDirSize
#modifyUserRecyclebinSpace
#modifyShareFolderUseSpace
#modifyShareFolderRBUS
#modifyAdminUseSpace

type=$1
case $type in
	-h)
		printf "Usage:$0 +[type] +{message}   e.g.\n  -h: for help\n  -u: Count Use Space By User\n     +admin: modify the space of admin\n     +{email}: modify the space of user\n  -s: Count ShareFolder Use Space\n  -all: modify all space of the enterprise\n"
	;;
	-u)
		user=$2
		case $2 in
			admin)
				echo -e "\e[1;32m modify admin Used_Spaces\e[0m"
				modifyAdminUseSpace
				echo -e "\e[1;32m update done\e[0m"
			;;
			*)
				echo -e "\e[1;32m modify user Used_Spaces\e[0m"
				modifyUserUseSpace $user
				echo -e "\e[1;32m modify user Recyclebin_Used_Spaces\e[0m"
				modifyUserRecyclebinSpace $user
				echo -e "\e[1;32m update done\e[0m"
			;;
		esac
	;;
	-s)
		echo -e "\e[1;32m modify shareFolder Used_Spaces\e[0m"
		modifyShareFolderUseSpace
		echo -e "\e[1;32m modify shareFolder Recycle_bin Used_Spaces\e[0m"
		modifyShareFolderRBUS
		echo -e "\e[1;32m update done\e[0m"
	;;
	-all)
		echo -e "\e[1;32m modify all user Spaces\e[0m"
		userAccountSql="select email from enterprisecloud.sursen_entc_user where role_name='user' and state=1"
		echo $userAccountSql
		mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${userAccountSql}"|grep -v email >userAccount
		for i in `cat userAccount`
		do
			modifyUserUseSpace $i
			modifyUserRecyclebinSpace $i
		done
		modifyShareFolderUseSpace
		modifyShareFolderRBUS
#		modifyAdminUseSpace
		rm -f userAccount
		echo -e "\e[1;32m update done\e[0m"
	;;
	*)
		$0 -h
	;;
esac
