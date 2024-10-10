#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if ufw is installed
ufw_installed() {
    if dpkg -l | grep -qw ufw; then
        return 0
    elif command_exists dnf && rpm -q ufw; then
        return 0
    elif command_exists rpm && rpm -q ufw; then
        return 0
    else
        return 1
    fi
}

# Check if ufw is installed
echo "Checking if Uncomplicated Firewall (ufw) is installed..."
if ufw_installed; then
    echo "ufw is already installed on this system."
else
    echo "ufw is not installed. Installing ufw..."

    # Determine which package manager to use for installation
    if command_exists apt; then
        echo "Using apt system - Installing ufw..."
        apt-get update && apt-get install -y ufw
    elif command_exists dnf; then
        echo "Using dnf system - Installing ufw..."
        dnf install -y ufw
    elif command_exists rpm; then
        echo "Using rpm-based system - Installing ufw..."
        rpm -i ufw
    else
        echo "ERROR: No suitable package manager found. Please install ufw manually."
        exit 1
    fi

    # Verify if the installation was successful
    if ufw_installed; then
        echo "ufw has been successfully installed."
    else
        echo "Failed to install ufw. Please check manually."
    fi
fi

echo "Script execution completed."
