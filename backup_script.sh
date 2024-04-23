#!/bin/bash

# Paths
log_file="/home/username/backup/backup.log"  
complete_backup_dir="/home/username/backup/cbw24"  
incremental_backup_dir="/home/username/backup/ib24"  
differential_backup_dir="/home/username/backup/db24"  

# Create backup
create_backup() {
    local backup_type=$1                       
    local log_message=$2                      
    local timestamp=$(date +"%a %d %b %Y %r %Z")  
    local tar_file=""                         

    ((cntr++))

    # Perform backup based on type
    case $backup_type in
        "complete")
            tar_file="cbw24-$cntr.tar"  
            tar -cf "$complete_backup_dir/$tar_file" -C /home/username .  
            ;;

        "differential")
            tar_file="differential_backup_$cntr.tar"  
            local modified_files=$(find /home/username -newer "$last_complete_backup" ! -type d)
            if [ -n "$modified_files" ]; then  
                tar -cf "$differential_backup_dir/$tar_file" --newer "$last_complete_backup" --diff --files-from <(echo "$modified_files")
            else
                log_message="No changes - Differential backup not created"  
            fi
            ;;

        "incremental")
            tar_file="ibw24-$cntr.tar"  
            local modified_files=$(find /home/username -newer "$last_complete_backup" ! -type d)
            if [ -n "$modified_files" ]; then  
                tar -cf "$incremental_backup_dir/$tar_file" --newer "$last_complete_backup" -C /home/username .  
            else
                log_message="No changes - Incremental backup not created"  
            fi
            ;;
    esac

    # Update log
    echo "$timestamp $log_message" >> "$log_file"

    # Update log with file creation
    if [ -n "$tar_file" ]; then
        echo "$timestamp $tar_file created" >> "$log_file"
    fi
}

# Counter
cntr=0
last_complete_backup=""

# Main loop
while true; do
    # Complete backup
    create_backup "complete"

    # Last complete backup timestamp
    last_complete_backup=$(date +"%Y-%m-%d %H:%M:%S")

    # Sleep
    sleep 120

    # Incremental backup
    create_backup "incremental"

    # Sleep
    sleep 120

    # Differential backup
    create_backup "differential"

    # Sleep
    sleep 120
done
