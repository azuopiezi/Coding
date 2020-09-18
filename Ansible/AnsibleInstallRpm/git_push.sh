#!/usr/bin/expect -f
set -x
git add .
read -p "请输入commit 信息": CommitMessage
git commit -m "${CommitMessage}"

#git 到远端服务器上 需要输入用户名和密码

spawn git push

expect {
  "*Username*:" { send "azuopiezi\r";exp_continue } 
  "*Password*:" { send "sX209@^Yj\r" }
}
interact
