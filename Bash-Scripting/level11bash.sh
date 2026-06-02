#!/bin/bash

dir="Arena_Boss"
threshold=50

usage=$(du -sm $dir | awk '{ print $1 }')
echo "$usage"

if [[ $usage -ge $threshold ]]; then
    echo "Usage is high now"
else
    echo "Your usage is: $usage mb"
fi