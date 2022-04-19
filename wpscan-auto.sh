TARGET="https://site.com"
API_TOKEN="1m4GnIY0iLjD9cbEyYVaFBdWbSo9INvz2aTiiIVIPAQ"
wpscan --url $TARGET —-output file.json --format json --api-token $API_TOKEN —-random-user-agent --enumerate u
python3 -m wpscan_out_parse file.json --format html > html_output.html		#html result