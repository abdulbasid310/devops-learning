#!/bin/bash

mkdir Arena_Boss
mkdir Victory_Archive

touch Arena_Boss/file1.txt
touch Arena_Boss/file2.txt
touch Arena_Boss/file3.txt
touch Arena_Boss/file4.txt
touch Arena_Boss/file5.txt

min_lines=1
max_lines=10

for file in Arena_Boss/*; do
    num_lines=$((RANDOM % max_lines + min_lines))
    for ((i=0; i<num_lines; i++)); do
        
        echo "line" >> $file
    done
    if grep "victory" $file; then
        mv $file Victory_Archive
    fi
done

ls -lhS Arena_Boss

