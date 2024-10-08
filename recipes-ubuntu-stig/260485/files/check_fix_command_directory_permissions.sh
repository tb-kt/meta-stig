#!/bin/sh

# Directories to check
directories="/bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin"

# Find directories that are group-writable or world-writable
echo "Checking permissions for system command directories..."
find $directories -perm /022 -type d -exec stat -c "%n %a" '{}' \; > /tmp/command_dir_permissions.txt

if [ -s /tmp/command_dir_permissions.txt ]; then
    echo "WARNING: The following directories have permissions that are too permissive:"
    cat /tmp/command_dir_permissions.txt

    # Fix the permissions for each directory found
    echo "Fixing directory permissions to 755..."
    find $directories -perm /022 -type d -exec chmod -R 755 '{}' \;

    # Re-check permissions after fix
    find $directories -perm /022 -type d -exec stat -c "%n %a" '{}' \; > /tmp/command_dir_permissions_after.txt
    if [ -s /tmp/command_dir_permissions_after.txt ]; then
        echo "Some directories still have permissions that are too permissive:"
        cat /tmp/command_dir_permissions_after.txt
        echo "Please check these directories manually."
    else
        echo "Permissions for all system command directories have been corrected to 755."
    fi
else
    echo "All system command directories already have appropriate permissions (755 or less permissive)."
fi

echo "Script execution completed."
