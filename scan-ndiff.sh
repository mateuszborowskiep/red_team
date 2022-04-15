#!/bin/sh
TARGETS="/home/Projects/red_team/targets.txt"
OPTIONS="-sV -Pn -script vuln -iL "
EXPORT="-oX"
date=`date +%F`
# METASPLOIT SCAN SCRIPT
METASPLOIT_SCAN_SCRIPT='./metasploit_scan_script'

nmap $OPTIONS $TARGETS $EXPORT scan-$date.xml

echo '*** HTML EXPORT ***'
xsltproc scan-$date.xml -o vuln-$date.htm  

echo '*** COMPARE RESULTS ***'
if [ -e scan-prev.xml ]; then
    ndiff scan-prev.xml scan-$date.xml > diff-$date
    echo "*** NDIFF RESULTS ***"
    cat diff-$date
    echo
fi

#xsltproc diff-$date.xml -o vuln_changes-$date.html  
ln -sf scan-$date.xml scan.prev.xml 

# report results in vuln-$date.html and vuln_changes-$date.html 

### METASPLOIT ###
echo 'metasploit is scanning...'
        
# start postgresql server
service postgresql start
        
# 
msfconsole -q -o "metasploit_scan.txt" -x "setg rhosts file:$TARGETS ; resource $METASPLOIT_SCAN_SCRIPT ; exit -y"