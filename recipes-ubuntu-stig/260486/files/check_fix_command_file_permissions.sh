#!/bin/sh

# Directories to check
directories="/bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin"

# Find files that are group-writable or world-writable
echo "Checking permissions for system command files..."
find $directories -perm /022 -type f -exec stat -c "%n %a" '{}' \; > /tmp/command_file_permissions.txt

if [ -s /tmp/command_file_permissions.txt ]; then
    echo "WARNING: The following files have permissions that are too permissive:"
    cat /tmp/command_file_permissions.txt

    # Fix the permissions for each file found
    echo "Fixing file permissions to 755..."
    find $directories -perm /022 -type f -exec chmod 755 '{}' \;

    # Re-check permissions after fix
    find $directories -perm /022 -type f -exec stat -c "%n %a" '{}' \; > /tmp/command_file_permissions_after.txt
    if [ -s /tmp/command_file_permissions_after.txt ]; then
        echo "Some files still have permissions that are too permissive:"
        cat /tmp/command_file_permissions_after.txt
        echo "Please check these files manually."
    else
        echo "Permissions for all system command files have been corrected to 755."
    fi
else
    echo "All system command files already have appropriate permissions (755 or less permissive)."
fi

echo "Script execution completed."
