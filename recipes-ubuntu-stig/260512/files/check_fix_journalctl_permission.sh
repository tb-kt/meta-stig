#!/bin/sh

# File to check permissions
journalctl_path="/usr/bin/journalctl"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if /usr/bin/journalctl exists
if [ ! -e "$journalctl_path" ]; then
    echo "ERROR: $journalctl_path does not exist on this system."
    exit 1
fi

# Check if /usr/bin/journalctl has permissions set to 740
echo "Checking permissions for $journalctl_path..."
current_permissions=$(stat -c "%a" $journalctl_path)

if [ "$current_permissions" != "740" ]; then
    echo "WARNING: $journalctl_path does not have permissions set to 740. Current permissions: $current_permissions"
    
    # Fix the permissions to 740
    if command_exists apt; then
        echo "Using apt system - Fixing permissions of $journalctl_path to 740..."
    elif command_exists dnf; then
        echo "Using dnf system - Fixing permissions of $journalctl_path to 740..."
    elif command_exists rpm; then
        echo "Using rpm-based system - Fixing permissions of $journalctl_path to 740..."
    fi

    # Set permissions to 740
    chmod 740 $journalctl_path

    # Re-check permissions after fix
    new_permissions=$(stat -c "%a" $journalctl_path)
    if [ "$new_permissions" = "740" ]; then
        echo "Permissions for $journalctl_path have been corrected to 740."
    else
        echo "Failed to correct permissions for $journalctl_path. Please check manually."
    fi
else
    echo "$journalctl_path already has permissions set to 740."
fi

echo "Script execution completed."
