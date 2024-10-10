#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if ufw is installed
ufw_installed() {
    if command_exists dpkg && dpkg -l | grep -qw ufw; then
        return 0
    elif command_exists dnf && rpm -q ufw; then
        return 0
    elif command_exists rpm && rpm -q ufw; then
        return 0
    else
        return 1
    fi
}

# Check if ufw is installed, if not install it
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
        exit 1
    fi
fi

# Check if ufw service is enabled and active
echo "Checking if ufw service is enabled and running..."
ufw_status=$(systemctl is-active ufw.service)
ufw_enabled=$(systemctl is-enabled ufw.service 2>/dev/null)

if [ "$ufw_status" != "active" ] || [ "$ufw_enabled" != "enabled" ]; then
    echo "WARNING: ufw service is not enabled and/or running. Enabling and starting ufw..."

    # Enable and start ufw service
    systemctl enable ufw.service --now

    # Re-check if ufw service is enabled and running
    ufw_status=$(systemctl is-active ufw.service)
    ufw_enabled=$(systemctl is-enabled ufw.service 2>/dev/null)

    if [ "$ufw_status" = "active" ] && [ "$ufw_enabled" = "enabled" ]; then
        echo "ufw service has been successfully enabled and started."
    else
        echo "Failed to enable and start ufw service. Please check manually."
        exit 1
    fi
else
    echo "ufw service is already enabled and running."
fi

echo "Script execution completed."
