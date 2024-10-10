#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if chrony is installed
chrony_installed() {
    if command_exists dpkg && dpkg -l | grep -qw chrony; then
        return 0
    elif command_exists dnf && rpm -q chrony; then
        return 0
    elif command_exists rpm && rpm -q chrony; then
        return 0
    else
        return 1
    fi
}

# Check if chrony is installed, if not install it
echo "Checking if chrony is installed..."
if chrony_installed; then
    echo "chrony is already installed on this system."
else
    echo "chrony is not installed. Installing chrony..."

    # Determine which package manager to use for installation
    if command_exists apt; then
        echo "Using apt system - Installing chrony..."
        apt-get update && apt-get install -y chrony
    elif command_exists dnf; then
        echo "Using dnf system - Installing chrony..."
        dnf install -y chrony
    elif command_exists rpm; then
        echo "Using rpm-based system - Installing chrony..."
        rpm -i chrony
    else
        echo "ERROR: No suitable package manager found. Please install chrony manually."
        exit 1
    fi

    # Verify if the installation was successful
    if chrony_installed; then
        echo "chrony has been successfully installed."
    else
        echo "Failed to install chrony. Please check manually."
        exit 1
    fi
fi

# Configure chrony to synchronize the system clock with a one-second step
echo "Configuring chrony to synchronize system clock when time difference exceeds one second..."
chrony_conf="/etc/chrony/chrony.conf"

if [ -f "$chrony_conf" ]; then
    echo "Adding makestep configuration to $chrony_conf..."

    # Add or update the makestep directive
    grep -q "^makestep" "$chrony_conf" && sed -i 's/^makestep.*/makestep 1 1/' "$chrony_conf" || echo "makestep 1 1" >> "$chrony_conf"

    echo "Restarting chrony service to apply changes..."
    systemctl restart chrony.service

    # Verify if chrony service is active
    chrony_status=$(systemctl is-active chrony.service)
    if [ "$chrony_status" = "active" ]; then
        echo "chrony service has been successfully restarted and is active."
    else
        echo "Failed to restart chrony service. Please check manually."
        exit 1
    fi
else
    echo "ERROR: $chrony_conf file does not exist. Please check chrony installation."
    exit 1
fi

# Verify NTP synchronization status
echo "Checking NTP synchronization status..."
timedatectl_status=$(timedatectl | grep -Ei '(synchronized|service)')
echo "$timedatectl_status"

if ! echo "$timedatectl_status" | grep -q "System clock synchronized: yes"; then
    echo "WARNING: System clock is not synchronized. Please check the configuration."
    exit 1
fi

if ! echo "$timedatectl_status" | grep -q "NTP service: active"; then
    echo "WARNING: NTP service is not active. Please check the configuration."
    exit 1
fi

echo "Script execution completed."
