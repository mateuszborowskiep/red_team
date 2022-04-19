Security inventory  
1) scan-ndiff.sh - script for automated vulnerability scan nmap&ndiff https://nmap.org/book/ndiff-man.html 
    Ndiff - looking for changes compare previous and current scan 
    Add script on crontab 
    0 11 28 1-12 * /root/scan-ndiff.sh - run once in month at 12 
2) wpscan - auto wordpress scan with wpscan, api, enumerate and randomize with export result to html 
