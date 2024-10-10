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

# Predefined list of allowed ports and services based on PPSM CAL
allowed_ports="22/tcp 80/tcp 443/tcp"  # Define your PPSM-approved ports and services here

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

# Enable ufw service if not already enabled
echo "Enabling ufw service if not already enabled..."
systemctl enable ufw.service --now

# Check if ufw is enabled
ufw_status=$(systemctl is-active ufw.service)
if [ "$ufw_status" != "active" ]; then
    echo "WARNING: Failed to enable ufw. Please enable it manually."
    exit 1
else
    echo "ufw service is enabled and running."
fi

# Configure ufw to allow only the ports defined in PPSM CAL and deny all others
echo "Configuring ufw to allow only approved ports and deny others..."
# Resetting existing ufw rules
ufw --force reset

# Allow necessary ports
for port in $allowed_ports; do
    echo "Allowing port: $port"
    ufw allow "$port"
done

# Set default policies to deny
echo "Setting default ufw policies to deny..."
ufw default deny incoming
ufw default allow outgoing

# Enable ufw if not already active
ufw enable

echo "Configuration completed. Verifying current ufw status..."

# Display current ufw status
ufw status verbose

echo "Script execution completed."
