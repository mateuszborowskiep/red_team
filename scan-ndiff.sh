#!/bin/sh
TARGETS="targets.txt"
OPTIONS="-sV -oA nmap-vuln -Pn -script vulnerability -iL "
date=`date +%F`
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