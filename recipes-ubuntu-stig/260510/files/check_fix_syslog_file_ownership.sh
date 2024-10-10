#!/bin/sh

# File to check ownership
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

# Check if /var/log/syslog is owned by syslog
echo "Checking ownership for $syslog_file..."
current_owner=$(stat -c "%U" $syslog_file)

if [ "$current_owner" != "syslog" ]; then
    echo "WARNING: $syslog_file is not owned by syslog. Current owner: $current_owner"
    
    # Fix the ownership to syslog
    if command_exists apt; then
        echo "Using apt system - Fixing ownership of $syslog_file to syslog..."
    elif command_exists dnf; then
        echo "Using dnf system - Fixing ownership of $syslog_file to syslog..."
    elif command_exists rpm; then
        echo "Using rpm-based system - Fixing ownership of $syslog_file to syslog..."
    fi

    # Set ownership to syslog
    chown syslog $syslog_file

    # Re-check ownership after fix
    new_owner=$(stat -c "%U" $syslog_file)
    if [ "$new_owner" = "syslog" ]; then
        echo "Ownership for $syslog_file has been corrected to syslog."
    else
        echo "Failed to correct ownership for $syslog_file. Please check manually."
    fi
else
    echo "$syslog_file is already owned by syslog."
fi

echo "Script execution completed."
