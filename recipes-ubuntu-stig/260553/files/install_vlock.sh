#!/bin/bash

# Description: This script installs the "vlock" package on Ubuntu 22.04 LTS, or the equivalent for RPM and DNF systems, to allow users to directly initiate a session lock.

# Function to determine package manager and install vlock
install_vlock() {
    if command -v apt-get &> /dev/null; then
        echo "Detected apt package manager. Installing vlock..."
        sudo apt-get update
        sudo apt-get install -y vlock
    elif command -v dnf &> /dev/null; then
        echo "Detected dnf package manager. Installing vlock..."
        sudo dnf install -y vlock
    elif command -v rpm &> /dev/null; then
        echo "Detected rpm package manager. Installing vlock..."
        sudo rpm -i vlock
    else
        echo "No supported package manager found. Cannot install vlock."
        exit 1
    fi
}

# Install vlock package
install_vlock

# Verify installation
if command -v vlock &> /dev/null; then
    echo "vlock successfully installed."
else
    echo "vlock installation failed."
    exit 1
fi
