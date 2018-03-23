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
#expect "# " { send "yum clean all\r" }
sleep 10
set timeout -1
expect "# " { send "yum --enablerepo=local-php54 update -y > /var/log/yum_auto.log\r" }
sleep 10
#expect "# " { send "scp -p /var/log/yum_auto.log *@*:/var/log/yum_auto_[lindex $argv 0].log\r" }
#expect "yes/no" {
#        send "yes\r"
#        expect "*?assword" { send "@root#\r" }
#        } "*?assword" { send "@root#\r" }
#set timeout 20
expect "# " { send "exit\r" }
expect "$ " { send "exit\r" }
interact
