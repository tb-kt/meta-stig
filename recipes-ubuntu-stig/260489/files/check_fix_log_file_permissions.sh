#!/bin/sh

# Directories to check for log files
log_directory="/var/log"

# Exclude btmp, wtmp, and lastlog files
excluded_files="*[bw]tmp *lastlog"

# Find log files that are group-writable or world-readable and not in the excluded files
echo "Checking permissions for log files in $log_directory..."
find $log_directory -perm /137 ! -name '*[bw]tmp' ! -name '*lastlog' -type f -exec stat -c "%n %a" '{}' \; > /tmp/log_file_permissions.txt

if [ -s /tmp/log_file_permissions.txt ]; then
    echo "WARNING: The following log files have permissions that are too permissive:"
    cat /tmp/log_file_permissions.txt

    # Fix the permissions for each file found
    echo "Fixing log file permissions to 640..."
    find $log_directory -perm /137 ! -name '*[bw]tmp' ! -name '*lastlog' -type f -exec chmod 640 '{}' \;

    # Re-check permissions after fix
    find $log_directory -perm /137 ! -name '*[bw]tmp' ! -name '*lastlog' -type f -exec stat -c "%n %a" '{}' \; > /tmp/log_file_permissions_after.txt
    if [ -s /tmp/log_file_permissions_after.txt ]; then
        echo "Some log files still have permissions that are too permissive:"
        cat /tmp/log_file_permissions_after.txt
        echo "Please check these files manually."
    else
        echo "Permissions for all log files have been corrected to 640."
    fi
else
    echo "All log files already have appropriate permissions (640 or less permissive)."
fi

echo "Script execution completed."
