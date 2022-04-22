#!/bin/sh
INTERFACE='eth0'                                    # change this
METASPLOIT_SCAN_SCRIPT='./metasploit_sniff' # METASPLOIT SCAN SCRIPT 

# start postgresql server
service postgresql start
        
 ### METASPLOIT ###
echo 'metasploit is scanning...'

msfconsole -q -o "metasploit_scan.txt" -x "setg interface $INTERFACE ; resource $METASPLOIT_SCAN_SCRIPT ; exit -y"