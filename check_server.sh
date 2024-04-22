#!/bin/bash

# Send an HTTP request to the Apache server
response=$(curl -s -o /dev/null -w "%{http_code}" http://192.168.33.12)

if [ $response -eq 200 ]; then
    echo "Apache server is up."
    # Optionally, you can log the uptime to a file
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Apache server is up." >> /path/to/uptime_log.txt
else
    echo "Apache server is down."
    # Optionally, you can send an email notification or take other actions
fi
