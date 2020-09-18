#!/bin/bash
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
