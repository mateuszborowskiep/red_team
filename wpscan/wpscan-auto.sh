TARGET="https://example.com"           #change target to full path website
API_TOKEN="XXXXXXXXXXXXXXXXXX"      #change token from wpscan site when you register 
wpscan --url $TARGET —-output file.json --format json --api-token $API_TOKEN —-random-user-agent --enumerate u
python3 -m wpscan_out_parse file.json --format html > html_output.html		#html result

