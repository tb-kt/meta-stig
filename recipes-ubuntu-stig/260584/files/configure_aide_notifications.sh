#!/bin/bash

# Description: This script installs and configures AIDE to notify designated personnel when unauthorized changes are detected.

# Function to install AIDE using apt
install_apt() {
    echo "Installing AIDE using apt..."
    sudo apt update && sudo apt install -y aide
}

# Function to install AIDE using dnf
install_dnf() {
    echo "Installing AIDE using dnf..."
    sudo dnf install -y aide
}

# Function to install AIDE using rpm
install_rpm() {
    echo "Installing AIDE using rpm..."
    sudo rpm -i aide
}

# Determine the package manager and install AIDE
if [ -x "$(command -v apt)" ]; then
    install_apt
elif [ -x "$(command -v dnf)" ]; then
    install_dnf
elif [ -x "$(command -v rpm)" ]; then
    install_rpm
else
    echo "Error: No supported package manager found (apt, dnf, rpm)."
    exit 1
fi

# Configure AIDE to notify designated personnel
echo "Configuring AIDE notification settings..."
AIDE_DEFAULT_CONF="/etc/default/aide"

if [ -f "$AIDE_DEFAULT_CONF" ]; then
    sudo sed -i 's/^\s*SILENTREPORTS.*/SILENTREPORTS=no/' "$AIDE_DEFAULT_CONF"
    if ! grep -q '^\s*SILENTREPORTS' "$AIDE_DEFAULT_CONF"; then
        echo "SILENTREPORTS=no" | sudo tee -a "$AIDE_DEFAULT_CONF"
    fi
else
    echo "SILENTREPORTS=no" | sudo tee "$AIDE_DEFAULT_CONF"
fi

# Initialize the AIDE database
echo "Initializing AIDE database..."
sudo aideinit

# Replace the default AIDE database
echo "Replacing default AIDE database with the newly generated one..."
sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Schedule AIDE check via cron to run daily and notify via email if there are changes
echo "Scheduling AIDE check via cron to run daily and notify via email..."
echo "0 5 * * * root /usr/bin/aide --check | mail -s 'AIDE Integrity Check Report' admin@example.com" | sudo tee /etc/cron.d/aide-check

echo "AIDE installation and configuration complete. Notification settings have been updated."
