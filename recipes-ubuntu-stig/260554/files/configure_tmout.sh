#!/bin/bash

# Description: This script configures the system to automatically exit interactive command shell user sessions after 15 minutes of inactivity.

# Function to configure TMOUT
configure_tmout() {
    local profile_file="/etc/profile.d/99-terminal_tmout.sh"

    # Set TMOUT environment variable for future sessions
    echo "Setting TMOUT to 900 seconds (15 minutes)"
    sudo bash -c "echo 'TMOUT=900' >> ${profile_file}"
    sudo bash -c "echo 'export TMOUT' >> ${profile_file}"

    # Set TMOUT environment variable for current session
    export TMOUT=900
    echo "TMOUT set to 900 seconds for current session"
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
configure_tmout

echo "Configuration completed successfully!"
