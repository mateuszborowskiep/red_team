#!/bin/sh
TARGETS="targets.txt"
OPTIONS="-sV -oA nmap-vuln -Pn -script vulnerability -iL "
date=`date +%F`
# METASPLOIT SCAN SCRIPT
METASPLOIT_SCAN_SCRIPT='./metasploit_scan_script'


cd /root/scans
nmap $OPTIONS $TARGETS -oA scan-$date > /dev/null
if [ -e scan-prev.xml ]; then
    ndiff scan-prev.xml scan-$date.xml > diff-$date
    echo "*** NDIFF RESULTS ***"
    cat diff-$date
    echo
fi 
echo "*** NMAP RESULTS *** "
cat scan-$date.nmap 
echo '*** HTML EXPORT and CLEANING ***'
xsltproc scan-$date.xml -o vuln-$date.html  
ndiff scan-prev.xml scan-$date.xml --xml diff-$date.xml  
xsltproc diff-$date.xml -o vuln_changes-$date.html  
ln -sf scan-$date.xml scan.prev.xml 

# report results in vuln-$date.html and vuln_changes-$date.html 

 ### METASPLOIT ###
print_succ 'metasploit is scanning...'
        
# start postgresql server
service postgresql start
        
# 
msfconsole -q -o "$FILE_PATH/IG/metasploit_scan.txt" -x "setg rhosts $TARGETS ; resource $METASPLOIT_SCAN_SCRIPT ; exit -y"

        