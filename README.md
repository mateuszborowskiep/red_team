Security inventory  
1) nmap - scan-ndiff.sh - script for automated vulnerability scan nmap&ndiff&metasploit https://nmap.org/book/ndiff-man.html 
    Ndiff - looking for changes compare previous and current scan 
    Add script on crontab 
    0 11 28 1-12 * /root/scan-ndiff.sh - run once in month at 12 
2) wpscan - auto wordpress scan with wpscan, api, enumerate and randomize with export result to html 
3) metasploit-scan - metasploit auto-scan for specified targets in file separetly instruction in metasploit_scan_script
4) parser - nmap result parsing host_up and list off services 
5) bruteforce - files with sample credentials 


TD:
1) metasploit full scanner 