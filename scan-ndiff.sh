#!/bin/sh
# requirement packages nmap, ndiff, metasploit-module, xsltproc
TARGETS="/home/Projects/red_team/targets.txt"       # change this
OPTIONS="-sV -Pn -script vuln -iL "
EXPORT="-oX"
USER_FILE='/home/Projects/red_team/users.txt'       # change this
PASS_FILE='/home/Projects/red_team/passwords.txt'   # change this 
date=`date +%F`
# METASPLOIT SCAN SCRIPT
METASPLOIT_SCAN_SCRIPT='./metasploit_scan_script'

nmap $OPTIONS $TARGETS $EXPORT scan-$date.xml

echo '*** HTML EXPORT ***'
xsltproc scan-$date.xml -o vuln-$date.htm  

echo '*** COMPARE RESULTS ***'
if [ -e scan-prev.xml ]; then
    ndiff scan-prev.xml scan-$date.xml > diff-$date.xml
    echo "*** NDIFF RESULTS ***"
    cat diff-$date
    echo
fi

xsltproc diff-$date.xml -o vuln_changes-$date.html  
ln -sf scan-$date.xml scan.prev.xml 

# report results in vuln-$date.html and vuln_changes-$date.html 

### METASPLOIT ###
echo 'metasploit is scanning...'
        
# start postgresql server
service postgresql start
        
# 
msfconsole -q -o "metasploit_scan.txt" -x "setg rhosts file:$TARGETS ; setg $USER_FILE ; setg $PASS_FILE resource $METASPLOIT_SCAN_SCRIPT ; exit -y"