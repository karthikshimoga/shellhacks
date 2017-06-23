#!/bin/bash

# Hostname and port has to be passed and certificate expiry date for that hostname is taken, doing the difference between the END #date and current date will be sent as Result Value.
#If the difference in days is positive, it will display value, if it is already expired, it will exit with availability of zero

filename=/root/kns/certs
while read  line; do

echo  "openssl s_client -servername $line -connect $line 2>/dev/null | openssl x509 -noout -dates | grep notAfter | cut -d= -f2 | cut -d" " -f1,2,4"
dcert=$(echo | openssl s_client -servername $line -connect $line 2>/dev/null | openssl x509 -noout -dates | grep notAfter | cut -d= -f2 | cut -d" " -f1,2,4)

date1=$(date | cut -d" " -f2,3,6)
echo Hostname : $line
endDate=$(date -d "$dcert" +"%Y%m%d")
currentDate=$(date -d "$date1" +"%Y%m%d")
echo $endDate $currentDate
   d1=$(date -d "$endDate" +%s)
   d2=$(date -d "$currentDate" +%s)

    if(echo $(( (d1 - d2) / 86400 )) > 0); then
       echo $(( (d1 - d2) / 86400 )) days remaining
       exit 0
    else
       exit 1
    fi


done < $filename
