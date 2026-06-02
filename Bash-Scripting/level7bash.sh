#!/bin/bash

echo "Which directory should we check?"
read dir

sort_listed=()
sort() {
    ls -lhS $dir
}

sort