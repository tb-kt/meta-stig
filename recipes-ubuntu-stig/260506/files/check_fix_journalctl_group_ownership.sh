#!/bin/sh

# File to check group ownership
journalctl_path="/usr/bin/journalctl"

# Check if journalctl is group-owned by root
echo "Checking group ownership for $journalctl_path..."
current_group=$(stat -c "%G" $journalctl_path)

if [ "$current_group" != "root" ]; then
    echo "WARNING: $journalctl_path is not group-owned by root. Current group: $current_group"
    
    # Fix the group ownership to root
    echo "Fixing group ownership to root..."
    chown :root $journalctl_path

    # Re-check group ownership after fix
    new_group=$(stat -c "%G" $journalctl_path)
    if [ "$new_group" = "root" ]; then
        echo "Group ownership for $journalctl_path has been corrected to root."
    else
        echo "Failed to correct group ownership for $journalctl_path. Please check manually."
    fi
else
    echo "$journalctl_path is already group-owned by root."
fi

echo "Script execution completed."
