#!/bin/bash
FILE="./arena/warrior.txt"

if [[ -f $FILE ]]; then
    echo "Hero found"
else
    echo "Hero missing"
fi 

DIR="./arena"

mkdir backup
for file in $DIR/*.txt ; do
    echo "$file"
    cp $file backup/
done
    