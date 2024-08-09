#!/bin/bash

while true; do
  server_list=$(speedtest-cli --list | grep -E '^[ ]*[0-9]+\)' | awk '{print $1}' | tr -d ')')
  saveTo='speedtest_15.csv'
  echo "Timestamp,$(speedtest-cli --csv-header)" > speedtest_15.csv


  for server in ${server_list[@]}; do
    now=$(TZ="Asia/Bangkok" date +"%a %d %b %Y %I:%M:%S %p UTC")
    echo "Server ID:" $server"," $now

    result=$(speedtest-cli --csv --server $server)
    if echo "$result" | grep -q "Cannot retrieve speedtest configuration"; then
       echo "ERROR: No matched server ID: $SERVER_ID"
    else
      timestamp=$(date +"%d-%m-%Y %H:%M:%S") 
      echo "$timestamp,$result" >> $saveTo
    fi
    echo "DONE!!!!"
  done
  echo "Test Completed"
  sleep $((60))
done
