#!/usr/bin/expect
#Usage sshsudologin.expect <host> <port> <ssh user> <ssh password>
set timeout 60

spawn scp -P [lindex $argv 1] -p  [lindex $argv 2]@[lindex $argv 0]:/var/log/yum_auto.log /var/log/yum_auto_[lindex $argv 0].log

expect "yes/no" { 
	send "yes\r"
	expect "*?assword" { send "[lindex $argv 3]\r" }
	} "*?assword" { send "[lindex $argv 3]\r" }

interact
