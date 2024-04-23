# Automated Backup Script

This is a Bash script designed to automate the process of creating complete, incremental, and differential backups of your files and directories.

## Overview

The script performs the following types of backups:

- **Complete Backup**: Creates a full backup of all files and directories.
- **Incremental Backup**: Creates a backup of only the files that have been modified since the last complete backup.
- **Differential Backup**: Creates a backup of only the files that have been modified since the last complete backup, but in a different format than incremental backup.

The script logs backup operations and their outcomes to a specified log file for tracking and monitoring purposes.

## Prerequisites

- **Bash**: The script is written in Bash and requires a Bash-compatible shell environment.
- **`tar`**: The script utilizes the `tar` command for creating and managing backups.

## Usage

1. **Clone the Repository**: Clone this repository to your local machine.

    ```bash
    git clone https://github.com/yourusername/your-repo.git
    ```

2. **Navigate to the Script Directory**: Navigate to the directory containing the backup script.

    ```bash
    cd your-repo
    ```

3. **Modify Paths (Optional)**: If needed, modify the paths in the script to match your desired backup locations and log file path.

4. **Make the Script Executable**: Make the script executable to allow it to be run.

    ```bash
    chmod +x backup_script.sh
    ```

5. **Run the Script**: Execute the script to start the automated backup process.

    ```bash
    ./backup_script.sh
    ```

6. **Monitor Logs**: Monitor the log file specified in the script to track backup operations and outcomes.

    ```bash
    tail -f /home/username/backup/backup.log
    ```

## Customization

- **Backup Frequency**: Adjust the sleep durations between different types of backups according to your preferences.
- **Backup Types**: Customize the script to include additional backup types or modify existing ones to suit your requirements.
- **Logging**: Modify the logging mechanism to include additional information or integrate with external monitoring tools.
