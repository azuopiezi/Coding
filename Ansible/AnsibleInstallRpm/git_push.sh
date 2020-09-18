#!/bin/bash
set -x
read -p "请输入文件路径或者文件目录": Path
git add .
read -p "请输入commit 信息": CommitMessage
git commit -m "${CommitMessage}"

#git 到远端服务器上 需要输入用户名和密码
echo “username=azuopiezi,password=sX209@^Yj”
git push


