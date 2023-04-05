#!/bin/bash

# Set the source directory and target directory
SOURCE_DIR="/mnt/c/users/admin/desktop/root/"
TARGET_DIR="/mnt/c/users/admin/desktop/backup/"
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory does not exist, backing up to remote destination"
    
    # Create the remote directory if it does not exist

    ssh "$REMOTE_USER@$REMOTE_HOST" "mkdir -p /"$REMOTE_DIR/$(date +%Y-%m-%d-%H-%M-%S)""

    # Backup the source directory to the remote destination
    rsync -avz  /$SOURCE_DIR hardi@192.168.0.32:/home/hardi/$TIMESTAMP/

else
    echo "Target directory exists, backing up to local directory"
    
    # Set the timestamped target directory
    TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
    BACKUP_DIR="$TARGET_DIR/$TIMESTAMP"
    
    # Create the timestamped target directory
    mkdir -p "$BACKUP_DIR"
    
    # Backup the source directory to the timestamped target directory
    rsync -avz  "$SOURCE_DIR" "$BACKUP_DIR"
fi