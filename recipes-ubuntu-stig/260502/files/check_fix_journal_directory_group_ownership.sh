#!/bin/sh

# Directories to check for group ownership
directories="/run/log/journal /var/log/journal"

# Find directories that are not group-owned by systemd-journal
echo "Checking group ownership for journal directories in $directories..."
find $directories -type d -exec stat -c "%n %G" '{}' \; | grep -v " systemd-journal" > /tmp/journal_directory_group_ownership.txt

if [ -s /tmp/journal_directory_group_ownership.txt ]; then
    echo "WARNING: The following journal directories are not group-owned by systemd-journal:"
    cat /tmp/journal_directory_group_ownership.txt

    # Fix the group ownership for each directory found
    echo "Fixing group ownership to systemd-journal..."
    while IFS= read -r line; do
        directory=$(echo $line | awk '{print $1}')
        chgrp systemd-journal "$directory"
    done < /tmp/journal_directory_group_ownership.txt

    # Re-check group ownership after fix
    find $directories -type d -exec stat -c "%n %G" '{}' \; | grep -v " systemd-journal" > /tmp/journal_directory_group_ownership_after.txt
    if [ -s /tmp/journal_directory_group_ownership_after.txt ]; then
        echo "Some journal directories are still not group-owned by systemd-journal:"
        cat /tmp/journal_directory_group_ownership_after.txt
        echo "Please check these directories manually."
    else
        echo "Group ownership for all journal directories has been corrected to systemd-journal."
    fi
else
    echo "All journal directories are already group-owned by systemd-journal."
fi

echo "Script execution completed."
