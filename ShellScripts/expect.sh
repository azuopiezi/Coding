#!/usr/bin/expect

proc do_console_login {login pass} {
	set timeout 5
	set done 1
	set timeout_case 0
while ($done) {
	expect {
	"console login:" {send "$loginn"}
	"*password:" {send "$passn"}
"#" {
set done 0
send_user "nnLogin Successfully...nn"
		
		}
	timeout {
		switch -- $timeout_case {
		0 {send "n"}
	1 {
			send_user "Send a return...n"
			send "n"
		}
	2 {
		puts stderr "Login time out...n"
		exit 1
		}
			}
			incr timeout_case
		
		}
	
		}
	}
}



proc do_exec_cmd {} {
	set timeout 5
	send "n"
	expect "#"
	send "uname -pn"
	expect "#"
	send "ifconfig -an"
	expect "#"
	send "exitn"
	expect "login:"
	send_user "nnFinished....nn"
	
}

if {$argc < 2} {
	puts stderr "Usage: $argv0 login password.n"
	exit 1
	
}
set LOGIN [lindex $argv 0]
set PASS [lindex $argv 1]
spawn telnet 10.10.3.11 7001
do_console_login $LOGIN $PASS
do_exec_cmd
close
exit 0




