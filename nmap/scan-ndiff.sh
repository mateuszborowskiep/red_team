#!/bin/sh
# requirement packages nmap, ndiff, metasploit-module, xsltproc
TARGETS="./targets.txt"       # change this
OPTIONS="-sV -Pn -script vuln,dns-brute,http-brute,http-form-brute,imap-brute,ipmi-brute,iscsi-brute,krb5-enum-users,ldap-brute,mikrotik-routeros-brute, -iL "
EXPORT="-oX"
date=`date +%F`

nmap $OPTIONS $TARGETS $EXPORT scan-$date.xml

echo '*** HTML EXPORT ***'
xsltproc scan-$date.xml -o vuln-$date.htm  

echo '*** COMPARE RESULTS ***'
if [ -e scan-prev.xml ]; then
    ndiff scan-prev.xml scan-$date.xml > diff-$date.xml
    xsltproc diff-$date.xml -o vuln_changes-$date.html  
    echo "*** NDIFF RESULTS ***"
    cat diff-$date
    echo
fi

ln -sf scan-$date.xml scan.prev.xml 

# report results in vuln-$date.html and vuln_changes-$date.html 

