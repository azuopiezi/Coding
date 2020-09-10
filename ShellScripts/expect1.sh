#!/bin/expect

#first give the user some time to logout
exec sleep 4
spawn tip modem
expect "*connected*"
send "ATD [index $argv 1]"
#modem takes a whie to connect
set timeout 60
expect "*CONNECT*"