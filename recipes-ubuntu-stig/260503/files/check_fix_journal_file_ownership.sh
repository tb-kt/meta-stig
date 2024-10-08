#!/bin/sh

# Directories to check for file ownership
directories="/run/log/journal /var/log/journal"

# Find files that are not owned by root
echo "Checking ownership for journal files in $directories..."
find $directories -type f -exec stat -c "%n %U" '{}' \; | grep -v " root" > /tmp/journal_file_ownership.txt

if [ -s /tmp/journal_file_ownership.txt ]; then
    echo "WARNING: The following journal files are not owned by root:"
    cat /tmp/journal_file_ownership.txt

    # Fix the ownership for each file found
    echo "Fixing ownership to root..."
    while IFS= read -r line; do
        file=$(echo $line | awk '{print $1}')
        chown root "$file"
    done < /tmp/journal_file_ownership.txt

    # Re-check ownership after fix
    find $directories -type f -exec stat -c "%n %U" '{}' \; | grep -v " root" > /tmp/journal_file_ownership_after.txt
    if [ -s /tmp/journal_file_ownership_after.txt ]; then
        echo "Some journal files are still not owned by root:"
        cat /tmp/journal_file_ownership_after.txt
        echo "Please check these files manually."
    else
        echo "Ownership for all journal files has been corrected to root."
    fi
else
    echo "All journal files are already owned by root."
fi

echo "Script execution completed."
