#!/bin/sh

# Directories to check for library files
directories="/lib /lib64 /usr/lib"

# Find files that are group-writable or world-writable
echo "Checking permissions for library files in $directories..."
find $directories -perm /022 -type f -exec stat -c "%n %a" '{}' \; > /tmp/library_file_permissions.txt

if [ -s /tmp/library_file_permissions.txt ]; then
    echo "WARNING: The following library files have permissions that are too permissive:"
    cat /tmp/library_file_permissions.txt

    # Fix the permissions for each file found
    echo "Fixing library file permissions to 755..."
    find $directories -perm /022 -type f -exec chmod 755 '{}' \;

    # Re-check permissions after fix
    find $directories -perm /022 -type f -exec stat -c "%n %a" '{}' \; > /tmp/library_file_permissions_after.txt
    if [ -s /tmp/library_file_permissions_after.txt ]; then
        echo "Some library files still have permissions that are too permissive:"
        cat /tmp/library_file_permissions_after.txt
        echo "Please check these files manually."
    else
        echo "Permissions for all library files have been corrected to 755."
    fi
else
    echo "All library files already have appropriate permissions (755 or less permissive)."
fi

echo "Script execution completed."
