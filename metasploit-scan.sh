#!/bin/sh
USER_FILE='bruteforce/users.txt'       # change this
PASS_FILE='bruteforce/passwords.txt'   # change this 
TARGETS="./targets.txt"       # change this
METASPLOIT_SCAN_SCRIPT='./metasploit_scan_script' # METASPLOIT SCAN SCRIPT 

# start postgresql server
service postgresql start
        
 ### METASPLOIT ###
echo 'metasploit is scanning...'
# scan command 
msfconsole -q -o "metasploit_scan.txt" -x "setg rhosts file:$TARGETS ; setg user_file $USER_FILE ; setg pass_file $PASS_FILE ; resource $METASPLOIT_SCAN_SCRIPT ; exit -y"