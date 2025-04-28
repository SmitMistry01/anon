#!/bin/bash

# Wait for the website to be up
sleep 10

# Check if the website is accessible
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80)

if [ "$response" -eq 200 ]; then
    echo "Website is accessible"
    exit 0
else
    echo "Website is not accessible. Response code: $response"
    exit 1
fi 