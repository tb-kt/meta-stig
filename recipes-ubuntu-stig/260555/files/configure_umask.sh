#!/bin/bash

# Description: This script configures the system to define default filesystem permissions such that authenticated users can only read and modify their own files.

# Function to configure UMASK
configure_umask() {
    local login_defs_file="/etc/login.defs"
    
    # Set UMASK to 077
    if grep -q '^UMASK' "$login_defs_file"; then
        echo "Updating UMASK to 077 in $login_defs_file"
        sudo sed -i 's/^UMASK.*/UMASK 077/' "$login_defs_file"
    else
        echo "Adding UMASK 077 to $login_defs_file"
        echo "UMASK 077" | sudo tee -a "$login_defs_file"
    fi
}

# Check for package manager and install necessary utilities
install_packages() {
    if command -v apt-get &> /dev/null; then
        echo "Detected apt package manager. Updating system..."
        sudo apt-get update
    elif command -v dnf &> /dev/null; then
        echo "Detected dnf package manager. Updating system..."
        sudo dnf update -y
    elif command -v rpm &> /dev/null; then
        echo "Detected rpm package manager. Updating system..."
        sudo rpm --rebuilddb
    else
        echo "No supported package manager found."
    fi
}

# Run the functions
install_packages
configure_umask

echo "UMASK configuration completed successfully!"
