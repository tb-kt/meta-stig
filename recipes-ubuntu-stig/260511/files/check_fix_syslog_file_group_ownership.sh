#!/bin/sh

# File to check group ownership
syslog_file="/var/log/syslog"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if /var/log/syslog exists
if [ ! -e "$syslog_file" ]; then
    echo "ERROR: $syslog_file does not exist on this system."
    exit 1
fi

# Check if /var/log/syslog is group-owned by adm
echo "Checking group ownership for $syslog_file..."
current_group=$(stat -c "%G" $syslog_file)

if [ "$current_group" != "adm" ]; then
    echo "WARNING: $syslog_file is not group-owned by adm. Current group: $current_group"
    
    # Fix the group ownership to adm
    if command_exists apt; then
        echo "Using apt system - Fixing group ownership of $syslog_file to adm..."
    elif command_exists dnf; then
        echo "Using dnf system - Fixing group ownership of $syslog_file to adm..."
    elif command_exists rpm; then
        echo "Using rpm-based system - Fixing group ownership of $syslog_file to adm..."
    fi

    # Set group ownership to adm
    chgrp adm $syslog_file

    # Re-check group ownership after fix
    new_group=$(stat -c "%G" $syslog_file)
    if [ "$new_group" = "adm" ]; then
        echo "Group ownership for $syslog_file has been corrected to adm."
    else
        echo "Failed to correct group ownership for $syslog_file. Please check manually."
    fi
else
    echo "$syslog_file is already group-owned by adm."
fi

echo "Script execution completed."
