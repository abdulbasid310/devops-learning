#!/bin/bash



echo "What would you like to do?"
echo "- to check disk usage type 1"
echo "- to show system uptime type 2"
echo "- to list users type 3"

read task

if [ $task -eq 1 ]; then
    # Checks disk space
    df -h 
elif [ $task -eq 2 ]; then
    # Shows system uptime
    uptime
elif [ $task -eq 3 ]; then
    # Lists users
    cut -d: -f1 /etc/passwd
else 
    echo "Please select one of the options"  
fi              