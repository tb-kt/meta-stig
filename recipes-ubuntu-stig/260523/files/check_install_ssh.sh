#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if SSH is installed
ssh_installed() {
    if command_exists dpkg && dpkg -l | grep -qw openssh-server; then
        return 0
    elif command_exists dnf && rpm -q openssh-server; then
        return 0
    elif command_exists rpm && rpm -q openssh-server; then
        return 0
    else
        return 1
    fi
}

# Check if SSH is installed, if not install it
echo "Checking if SSH is installed..."
if ssh_installed; then
    echo "SSH is already installed on this system."
else
    echo "SSH is not installed. Installing SSH..."

    # Determine which package manager to use for installation
    if command_exists apt; then
        echo "Using apt system - Installing SSH..."
        apt-get update && apt-get install -y openssh-server
    elif command_exists dnf; then
        echo "Using dnf system - Installing SSH..."
        dnf install -y openssh-server
    elif command_exists rpm; then
        echo "Using rpm-based system - Installing SSH..."
        rpm -i openssh-server
    else
        echo "ERROR: No suitable package manager found. Please install SSH manually."
        exit 1
    fi

    # Verify if the installation was successful
    if ssh_installed; then
        echo "SSH has been successfully installed."
    else
        echo "Failed to install SSH. Please check manually."
        exit 1
    fi
fi

echo "Script execution completed."
