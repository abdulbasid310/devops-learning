#!/bin/bash

config_file="config.conf"

if [ ! -f $config_file ]; then
    echo "Configuration file does not exist"
    exit 1
fi

while IFS='=' read -r key value; do
    echo "Key:$key Value:$value"

done < $config_file    