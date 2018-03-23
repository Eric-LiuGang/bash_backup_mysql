#!/usr/bin/expect
#Usage sshsudologin.expect <host> <port> <ssh user> <ssh password>
set timeout 60

spawn ssh -p [lindex $argv 1] [lindex $argv 2]@[lindex $argv 0]

expect "yes/no" { 
	send "yes\r"
	expect "*?assword" { send "[lindex $argv 3]\r" }
	} "*?assword" { send "[lindex $argv 3]\r" }

expect "# " { send "vmware-config-tools.pl\r" }
sleep 10
set timeout -1
expect "*no*" { send "\r" }
expect "*no*" { send "\r" }
expect "*no*" { send "\r" }
expect "*yes* " { send "\r" }
expect "*yes* " { send "\r" }
expect "# " { send "exit\r" }
interact
