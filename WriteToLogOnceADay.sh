#Change File names as per your requirement.
lastup=$(stat -c %Y sslcertMonitoring.log)
now=$(date +%s)
diff=$(($now - $lastup))
#Get difference in timestamp between last modified time of log file and current time
#If difference is greater than number of seconds in a day, write SSL difference days into log file
#echo $diff
diff_sec=$(($diff/43200))
echo $diff_sec

if  [ "$diff_sec" -eq 1 ]; then
./sslcertInfo.sh >> sslcertMonitoring.log
echo 21
exit 0
else
exit 0
fi
