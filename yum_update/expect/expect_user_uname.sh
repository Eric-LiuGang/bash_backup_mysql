#!/usr/bin/expect
#Usage sshsudologin.expect <host> <port> <ssh user> <ssh password> <su user> <su password>
set timeout 60

spawn ssh -p [lindex $argv 1] [lindex $argv 2]@[lindex $argv 0]

expect "yes/no" { 
	send "yes\r"
	expect "*?assword" { send "[lindex $argv 3]\r" }
	} "*?assword" { send "[lindex $argv 3]\r" }

expect "$ " { send "su - [lindex $argv 4]\r" }
expect ": " { send "[lindex $argv 5]\r" }
expect "# " { send "uname -r > /var/log/yum_uname.log\r" }
sleep 1
#expect "# " { send "scp -p /var/log/yum_uname.log *@*:/var/log/yum_uname_[lindex $argv 0].log\r" }
#expect "yes/no" {
#        send "yes\r"
#        expect "*?assword" { send "@root#\r" }
#        } "*?assword" { send "@root#\r" }
expect "# " { send "exit\r" }
expect "$ " { send "exit\r" }
interact
