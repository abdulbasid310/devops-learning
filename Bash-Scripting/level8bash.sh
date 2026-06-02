#!/bin/bash

echo "Which phrase are we searching for today?"
dir="mylogs"
read phrase

for file in $dir/*; do
    grep -l $phrase $file
done

