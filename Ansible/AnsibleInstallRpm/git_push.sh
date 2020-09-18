#!/usr/bin/expect -f
set -x
git add -A
read -p "请输入commit 信息": CommitMessage
git commit -m "${CommitMessage}"

#git 到远端服务器上 需要输入用户名和密码
user=azuopiezi
password=sX209@^Yj
expect << EOF
spawn git push
#expect "Username for 'https://github.com':"
expect "Username*"
send "${user}\r"
#expect "Password for 'https://azuopiezi@github.com"
expect "Password*"
send "${password}\r"
expect eof;
EOF
