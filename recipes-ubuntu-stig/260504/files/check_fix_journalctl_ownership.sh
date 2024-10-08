#!/bin/sh

# File to check ownership
journalctl_path="/usr/bin/journalctl"

# Check if journalctl is owned by root
echo "Checking ownership for $journalctl_path..."
current_owner=$(stat -c "%U" $journalctl_path)

if [ "$current_owner" != "root" ]; then
    echo "WARNING: $journalctl_path is not owned by root. Current owner: $current_owner"
    
    # Fix the ownership to root
    echo "Fixing ownership to root..."
    chown root $journalctl_path

    # Re-check ownership after fix
    new_owner=$(stat -c "%U" $journalctl_path)
    if [ "$new_owner" = "root" ]; then
        echo "Ownership for $journalctl_path has been corrected to root."
    else
        echo "Failed to correct ownership for $journalctl_path. Please check manually."
    fi
else
    echo "$journalctl_path is already owned by root."
fi

echo "Script execution completed."
