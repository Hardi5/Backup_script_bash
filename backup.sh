#!/bin/bash

# Set source and target directories and also add a timestamp
SOURCE_DIR="/mnt/c/users/admin/desktop/root/"
TARGET_DIR="/mnt/c/users/admin/desktop/backup/"
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

#Define remote variables
REMOTE_USER="hardi"
REMOTE_HOST="192.168.0.32"
REMOTE_DIR="/home/hardi"


# Check if target directory exists locally, if it doesnt, back up to remote(with ssh)
if [ ! -d "$TARGET_DIR" ]; then
    echo "Local target directory doesnt exist, backing up to remote location"

    # Create remote directory if it doesnt already exist

    ssh "$REMOTE_USER@$REMOTE_HOST" "mkdir -p /"$REMOTE_DIR/$TIMESTAMP""

    # Backup from source directory to remote location
    rsync -avz  /$SOURCE_DIR $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/$TIMESTAMP/

else 
    echo "Target exists locally, backing up"


    # Timestamp directory for local destination and then join it with target to equal backup_dir
    TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
    BACKUP_DIR="$TARGET_DIR/$TIMESTAMP"

    # Create the local dir. with timestamp
    mkdir -p "$BACKUP_DIR"

    # backup from source dir to local target dir
    rsync -avz  "$SOURCE_DIR" "$BACKUP_DIR"
fi