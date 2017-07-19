#!/bin/bash

#This will return count of established connections with the specific port number provided as argument.


echo $(date)
while read line; do
hostIp=$(echo $line | cut -f1 -d:)
hostUN=$(echo $line | cut -f2 -d:)
hostPwd=$(echo $line | cut -f3 -d:)

{
    /usr/bin/expect << EOF
    spawn -noecho ssh -o StrictHostKeyChecking=no $hostUN@$hostIp netstat -anp |  awk '{print $4}' | grep -w $1 |wc -l
    expect "*assword"
    send "$hostPwd\r"

    expect "*#*"
EOF
}
done <netstat > establishedCount.log
