#!/bin/bash
#---------------------
#Author:xiaoyaguang
#you should add 2 params
#1:email
#2:stepnum
#---------------------
if [ $# -ne 2 ];then
	echo "Error:Usage:$0 {email} [1/2]"
	exit 0
fi
if [ $2 -eq 1 ];then
	updatesql="update enterprisecloud.sursen_entc_user set state=0 where email='$1'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updatesql}"
	updatesql="update enterprisecloud.sursen_entc_user_key set email = '$1.bak' where email='$1'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updatesql}"
	updatesql="update frontserver.account set email = '$1.bak' where email = '$1'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updatesql}"
	updatesql="update frontserver.userpublickey set email = '$1.bak' where email = '$1'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updatesql}"
	updatesql1="update webdocbase.users set email = '$1.bak' where email = '$1'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33331 -e "${updatesql1}"
	updatesql="update enterprisecloud.sursen_entc_user_private_key set email='$1.bak' where email = '$1'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updatesql}"
	updatesql="update enterprisecloud.sursen_entc_user set real_name='$1.bak',nick_name='$1.bak',email='$1.bak' where email = '$1'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updatesql}"
elif [ $2 -eq 2 ];then
	updatesql2="update webdocbase.users set email = '$1.bak.bak' where email = '$1'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33331 -e "${updatesql2}"
	updatesql3="update webdocbase.users set email = '$1' where email = '$1.bak'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33331 -e "${updatesql3}"
	rootidsql="select root_folder_id from enterprisecloud.sursen_entc_user where email = '$1.bak'"
	rootdirid=`mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${rootidsql}"|grep -v root_folder_id`
	recyclebinsql="select recycle_bin_id from enterprisecloud.sursen_entc_user where email = '$1.bak'"
	recyclebinid=`mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${recyclebinsql}"|grep -v recycle_bin_id`
	useridsql="select id from enterprisecloud.sursen_entc_user where email = '$1.bak'"
	userid=`mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${useridsql}"|grep -v id`
	newUserIdSql="select id from enterprisecloud.sursen_entc_user where email = '$1'"
	newUserId=`mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${newUserIdSql}"|grep -v id`
	updatesql="update enterprisecloud.sursen_entc_user set root_folder_id='$rootdirid',recycle_bin_id='$recyclebinid' where email = '$1'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updatesql}"
	updatesql="update enterprisecloud.sursen_entc_user_folder_role_link set user_id='$newUserId' where user_id='$userid'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updatesql}"
	updatesql="update enterprisecloud.sursen_entc_user_role_link set user_id='$newUserId' where user_id='$userid'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updatesql}"
	updatesql="update enterprisecloud.sursen_entc_user_department_link set department_id='10000' where id='$userid'"
	mysql -h127.0.0.1 -usurdoc -psurdoc_23 -P33330 -e "${updatesql}"
else
	echo "Error:Usage:$0 {email} [1/2]"
fi
