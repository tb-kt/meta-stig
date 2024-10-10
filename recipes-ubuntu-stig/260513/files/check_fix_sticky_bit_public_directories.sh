#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Find all public directories without the sticky bit set
echo "Checking for public directories without sticky bit set..."
public_dirs=$(find / -type d -perm -002 ! -perm -1000 2>/dev/null)

if [ -n "$public_dirs" ]; then
    echo "WARNING: The following public directories do not have the sticky bit set:"
    echo "$public_dirs"
    
    # Fix the sticky bit for each directory found
    if command_exists apt; then
        echo "Using apt system - Setting sticky bit for public directories..."
    elif command_exists dnf; then
        echo "Using dnf system - Setting sticky bit for public directories..."
    elif command_exists rpm; then
        echo "Using rpm-based system - Setting sticky bit for public directories..."
    fi

    for dir in $public_dirs; do
        echo "Setting sticky bit for directory: $dir"
        chmod +t "$dir"

        # Re-check to verify if sticky bit was successfully set
        if [ -z "$(find "$dir" -type d ! -perm -1000 2>/dev/null)" ]; then
            echo "Sticky bit successfully set for directory: $dir"
        else
            echo "Failed to set sticky bit for directory: $dir. Please check manually."
        fi
    done
else
    echo "All public directories have the sticky bit set."
fi

echo "Script execution completed."
