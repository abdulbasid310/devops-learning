#!/bin/bash

dir="mylogs"

for file in $dir/*; do
    stat $file
done