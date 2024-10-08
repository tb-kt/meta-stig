#!/bin/sh

# Directories to check for library files
directories="/lib /lib64 /usr/lib"

# Find files that are not group-owned by root
echo "Checking group ownership for library files in $directories..."
find $directories ! -group root -type f -exec stat -c "%n %G" '{}' \; > /tmp/library_group_ownership.txt

if [ -s /tmp/library_group_ownership.txt ]; then
    echo "WARNING: The following library files are not group-owned by root:"
    cat /tmp/library_group_ownership.txt

    # Fix the group ownership for each file found
    echo "Fixing group ownership to root..."
    find $directories ! -group root -type f -exec chgrp root '{}' \;

    # Re-check group ownership after fix
    find $directories ! -group root -type f -exec stat -c "%n %G" '{}' \; > /tmp/library_group_ownership_after.txt
    if [ -s /tmp/library_group_ownership_after.txt ]; then
        echo "Some library files are still not group-owned by root:"
        cat /tmp/library_group_ownership_after.txt
        echo "Please check these files manually."
    else
        echo "Group ownership for all library files has been corrected to root."
    fi
else
    echo "All library files already have the correct group ownership (root)."
fi

echo "Script execution completed."
