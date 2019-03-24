#!/bin/bash

# variables
DAYS_TO_END=30
HTTPS_PORT=443
DOMAINS_LIST_FILE="./DOMAINS_TO_CHECK_CERTIFICATES" 
list_expired_domains=""

# main
finall_valid_date=$(date -d "+$DAYS_TO_END days" "+%s")

for domain in $(cat $DOMAINS_LIST_FILE ); do
	cert_finall_valid_date=$( echo | openssl s_client -showcerts -servername $domain -connect $domain:$HTTPS_PORT 2>/dev/null | openssl x509 -inform pem -noout -enddate | cut -d "=" -f 2 )
	cert_finall_valid_date_unix=$(date -d "${cert_finall_valid_date}" "+%s") 

	if [ $finall_valid_date -gt $cert_finall_valid_date_unix ]; then
		list_expired_domains+=" $domain"
	fi
done

#zabbix_sender -z zabbix.suppix.org -p 10051 -s "zabbix.server.org" -k ssl_check -o "$list_expired_domains" 

if [ -z "$list_expired_domains" ]; then
	echo "All certificates are valid."
else
	echo "Expired certificates: $list_expired_domains"
fi
