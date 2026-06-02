#!/bin/bash

echo "Choose an option"
echo "1. Check disk space"
echo "2. Show system uptime"
echo "3. Backup the Arena directory and keep the last 3 backups"
echo "4. Parse a configuration file settings.conf and display the values "


read -p "Enter your option" task

case $task in
    1) 
    df -h
    ;;
    2) 
    uptime
    ;;
    3) 
    DIR="Arena"
    BACKUPDIR="Arena_backup"

    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
    tar -czf "$BACKUPDIR/$BACKUP_NAME" $DIR
    echo "Created backup: $BACKUP_NAME"

    cd $BACKUPDIR || exit 1
    ls -ldt backup_* | tail -n +4 | while IFS= read -r file; do
        rm -rf $file
    done
    ;;
    4) 
    config_file="settings.conf"

    if [ ! -f $config_file ]; then
        echo "Configuration file does not exist"
        exit 1
    fi

    while IFS='=' read -r key value; do
        echo "Key:$key Value:$value"

    done < $config_file 
    ;;
    *)
    echo "Please select one of the options"

esac
