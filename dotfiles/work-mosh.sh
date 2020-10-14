#!/usr/bin/expect -f

set machine [lindex $argv 0];
set yubikey [lindex $argv 1];

set timeout -1
spawn mosh $machine
expect "Passcode or option"
send -- "$yubikey\n"
expect "justinstribling@"
interact
