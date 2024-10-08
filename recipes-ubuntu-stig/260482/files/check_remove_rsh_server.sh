#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if rsh-server package is installed using dpkg or rpm
if (command_exists dpkg && dpkg -l | grep -q rsh-server) || (command_exists rpm && rpm -q rsh-server >/dev/null 2>&1); then
    echo "rsh-server package is installed. Proceeding with removal..."

    # Remove rsh-server package using the appropriate package manager
    if command_exists apt; then
        echo "Using apt to remove rsh-server package..."
        apt purge rsh-server -y
        if [ $? -eq 0 ]; then
            echo "rsh-server package successfully removed using apt."
        else
            echo "Failed to remove rsh-server package using apt. Please check your network connection or package repository."
            exit 1
        fi
    elif command_exists dnf; then
        echo "Using dnf to remove rsh-server package..."
        dnf remove rsh-server -y
        if [ $? -eq 0 ]; then
            echo "rsh-server package successfully removed using dnf."
        else
            echo "Failed to remove rsh-server package using dnf. Please check your network connection or package repository."
            exit 1
        fi
    else
        echo "Unable to determine package manager. Please remove rsh-server manually."
        exit 1
    fi
else
    echo "rsh-server package is not installed on this system."
fi

echo "Script execution completed."
