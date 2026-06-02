#!/bin/bash
DIR="mylogs"
BACKUPDIR="mylogsbackup"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
tar -czf "$BACKUPDIR/$BACKUP_NAME" $DIR
echo "Created backup: $BACKUP_NAME"

cd $BACKUPDIR || exit 1
ls -ldt backup_* | tail -n +6 | while IFS= read -r file; do
    rm -rf $file
done