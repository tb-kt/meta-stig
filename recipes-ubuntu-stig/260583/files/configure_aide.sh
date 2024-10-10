#!/bin/bash

# Description: This script installs and configures AIDE to perform file integrity checking on Ubuntu 22.04 LTS.

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

# Initialize the AIDE database
echo "Initializing AIDE database..."
sudo aideinit

# Replace the default AIDE database
echo "Replacing default AIDE database with the newly generated one..."
sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Schedule AIDE check via cron to run daily
echo "Scheduling AIDE check via cron to run daily..."
echo "0 5 * * * root /usr/bin/aide --check" | sudo tee /etc/cron.d/aide-check

echo "AIDE installation and configuration complete."
