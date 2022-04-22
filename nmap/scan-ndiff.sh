#!/bin/sh
# requirement packages nmap, ndiff, metasploit-module, xsltproc
TARGETS="./targets.txt"                                 # change this
OPTIONS="-sV -Pn --script default,safe,intrusive -iL "  # options and categories to the script https://nmap.org/nsedoc/categories/version.html 
EXPORT="-oX"
date=`date +%F`

nmap $OPTIONS $TARGETS $EXPORT scan-$date.xml

echo '*** HTML EXPORT ***'
xsltproc scan-$date.xml -o vuln-$date.htm  

echo '*** COMPARE RESULTS ***'
if [ -e scan-prev.xml ]; then
    ndiff --xml diff-$date.xml scan-prev.xml scan-$date.xml 
    xsltproc diff-$date.xml -o vuln_changes-$date.html  
    echo "*** NDIFF RESULTS ***"
    cat diff-$date
    echo
fi

ln -sf scan-$date.xml scan.prev.xml 

# look at report results in vuln-$date.html and vuln_changes-$date.html 

