#!/bin/sh

# Directories to check for ownership
directories="/run/log/journal /var/log/journal"

# Find directories that are not owned by root
echo "Checking ownership for journal directories in $directories..."
find $directories -type d -exec stat -c "%n %U" '{}' \; | grep -v " root" > /tmp/journal_directory_ownership.txt

if [ -s /tmp/journal_directory_ownership.txt ]; then
    echo "WARNING: The following journal directories are not owned by root:"
    cat /tmp/journal_directory_ownership.txt

    # Fix the ownership for each directory found
    echo "Fixing ownership to root..."
    while IFS= read -r line; do
        directory=$(echo $line | awk '{print $1}')
        chown root:root "$directory"
    done < /tmp/journal_directory_ownership.txt

    # Re-check ownership after fix
    find $directories -type d -exec stat -c "%n %U" '{}' \; | grep -v " root" > /tmp/journal_directory_ownership_after.txt
    if [ -s /tmp/journal_directory_ownership_after.txt ]; then
        echo "Some journal directories are still not owned by root:"
        cat /tmp/journal_directory_ownership_after.txt
        echo "Please check these directories manually."
    else
        echo "Ownership for all journal directories has been corrected to root."
    fi
else
    echo "All journal directories are already owned by root."
fi

echo "Script execution completed."
