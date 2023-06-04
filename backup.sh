#!/bin/bash

# Prompt for source dir
read -p "Enter the source directory: " SOURCE_DIR

# Prompt for target dir
read -p "Enter the target directory: " TARGET_DIR

# Check if target exists locally, if it doesnt prompt for remote details
if [ ! -d "$TARGET_DIR" ]; then
    echo "Local target doesnt exist, prompting for remote location details"

    # Prmopt for remote user
    read -p "Enter the remote user: " REMOTE_USER

    # Prompt for remote host 
    read -p "Enter the remote host: " REMOTE_HOST

    # Prompt for remote path destination
    read -p "Enter the remote directory: " REMOTE_DIR

    # Creating a timestamp
    TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

    # Backup from local directory to remote
    rsync -avz -e "ssh" "$SOURCE_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/$TIMESTAMP/"

else 
    echo "Target exists locally, backing up"

    # Timestamp directory for local destination and then join it with target to equal backup_dir
    TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
    
    BACKUP_DIR="$TARGET_DIR/$TIMESTAMP"

    # Create the local dir. with timestamp
    mkdir -p "$BACKUP_DIR"

    # backup from source dir to local target dir
    rsync -avz  "$SOURCE_DIR/" "$BACKUP_DIR/"
fi