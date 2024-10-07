#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if ntp package is installed using dpkg or rpm
if (command_exists dpkg && dpkg -l | grep -q ntp) || (command_exists rpm && rpm -q ntp >/dev/null 2>&1); then
    echo "ntp package is installed. Proceeding with removal..."

    # Remove ntp package using the appropriate package manager
    if command_exists apt; then
        echo "Using apt to remove ntp package..."
        apt purge ntp -y
        if [ $? -eq 0 ]; then
            echo "ntp package successfully removed using apt."
        else
            echo "Failed to remove ntp package using apt. Please check your network connection or package repository."
            exit 1
        fi
    elif command_exists dnf; then
        echo "Using dnf to remove ntp package..."
        dnf remove ntp -y
        if [ $? -eq 0 ]; then
            echo "ntp package successfully removed using dnf."
        else
            echo "Failed to remove ntp package using dnf. Please check your network connection or package repository."
            exit 1
        fi
    else
        echo "Unable to determine package manager. Please remove ntp manually."
        exit 1
    fi
else
    echo "ntp package is not installed on this system."
fi

echo "Script execution completed."
