#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if libpam-pwquality is installed using either dpkg or rpm
if (command_exists dpkg && dpkg -l | grep -q libpam-pwquality) || (command_exists rpm && rpm -q libpwquality >/dev/null 2>&1); then
    echo "libpam-pwquality (or equivalent) is already installed."
else
    echo "libpam-pwquality (or equivalent) is not installed. Proceeding with installation..."

    # Install libpam-pwquality package
    if command_exists apt; then
        echo "Using apt to install libpam-pwquality..."
        apt update && apt install libpam-pwquality -y
        if [ $? -eq 0 ]; then
            echo "libpam-pwquality successfully installed using apt."
        else
            echo "Failed to install libpam-pwquality using apt. Please check your network connection or package repository."
            exit 1
        fi
    elif command_exists dnf; then
        echo "Using dnf to install libpwquality..."
        dnf install libpwquality -y
        if [ $? -eq 0 ]; then
            echo "libpwquality successfully installed using dnf."
        else
            echo "Failed to install libpwquality using dnf. Please check your network connection or package repository."
            exit 1
        fi
    else
        echo "Unable to determine package manager. Please install libpam-pwquality manually."
        exit 1
    fi
fi

echo "Script execution completed."
