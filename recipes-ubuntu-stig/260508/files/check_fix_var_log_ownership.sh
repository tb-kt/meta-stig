#!/bin/sh

# Directory to check ownership
log_dir="/var/log"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if /var/log is owned by root
echo "Checking ownership for $log_dir..."
current_owner=$(stat -c "%U" $log_dir)

if [ "$current_owner" != "root" ]; then
    echo "WARNING: $log_dir is not owned by root. Current owner: $current_owner"
    
    # Fix the ownership to root
    if command_exists apt; then
        echo "Using apt system - Fixing ownership of $log_dir to root..."
    elif command_exists dnf; then
        echo "Using dnf system - Fixing ownership of $log_dir to root..."
    elif command_exists rpm; then
        echo "Using rpm-based system - Fixing ownership of $log_dir to root..."
    fi
    
    # Set ownership to root
    chown root $log_dir

    # Re-check ownership after fix
    new_owner=$(stat -c "%U" $log_dir)
    if [ "$new_owner" = "root" ]; then
        echo "Ownership for $log_dir has been corrected to root."
    else
        echo "Failed to correct ownership for $log_dir. Please check manually."
    fi
else
    echo "$log_dir is already owned by root."
fi

echo "Script execution completed."
