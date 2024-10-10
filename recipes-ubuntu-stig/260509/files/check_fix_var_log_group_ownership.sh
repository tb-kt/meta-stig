#!/bin/sh

# Directory to check group ownership
log_dir="/var/log"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if /var/log is group-owned by syslog
echo "Checking group ownership for $log_dir..."
current_group=$(stat -c "%G" $log_dir)

if [ "$current_group" != "syslog" ]; then
    echo "WARNING: $log_dir is not group-owned by syslog. Current group: $current_group"
    
    # Fix the group ownership to syslog
    if command_exists apt; then
        echo "Using apt system - Fixing group ownership of $log_dir to syslog..."
    elif command_exists dnf; then
        echo "Using dnf system - Fixing group ownership of $log_dir to syslog..."
    elif command_exists rpm; then
        echo "Using rpm-based system - Fixing group ownership of $log_dir to syslog..."
    fi

    # Set group ownership to syslog
    chgrp syslog $log_dir

    # Re-check group ownership after fix
    new_group=$(stat -c "%G" $log_dir)
    if [ "$new_group" = "syslog" ]; then
        echo "Group ownership for $log_dir has been corrected to syslog."
    else
        echo "Failed to correct group ownership for $log_dir. Please check manually."
    fi
else
    echo "$log_dir is already group-owned by syslog."
fi

echo "Script execution completed."
