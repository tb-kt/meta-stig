#!/bin/bash

# Description: This script verifies that the default AIDE script for checking file integrity every 30 days or less is unchanged.

# Function to install AIDE using apt
install_aide_apt() {
    echo "Installing AIDE using apt..."
    sudo apt update && sudo apt install -y aide aide-common
}

# Function to install AIDE using dnf
install_aide_dnf() {
    echo "Installing AIDE using dnf..."
    sudo dnf install -y aide
}

# Function to install AIDE using rpm
install_aide_rpm() {
    echo "Installing AIDE using rpm..."
    sudo rpm -i aide
}

# Determine the package manager and install AIDE
if [ -x "$(command -v apt)" ]; then
    install_aide_apt
elif [ -x "$(command -v dnf)" ]; then
    install_aide_dnf
elif [ -x "$(command -v rpm)" ]; then
    install_aide_rpm
else
    echo "Error: No supported package manager found (apt, dnf, rpm)."
    exit 1
fi

# Download the original aide-common package to verify the cron script
echo "Downloading the original aide-common package to verify the cron script..."
cd /tmp || exit
apt download aide-common

# Extract the original AIDE cron script from the package
echo "Extracting the original AIDE cron script..."
dpkg-deb --fsys-tarfile /tmp/aide-common_*.deb | tar -xO ./usr/share/aide/config/cron.daily/aide > /tmp/original_aide_script

# Get SHA1 hash of the original cron script
ORIGINAL_HASH=$(sha1sum /tmp/original_aide_script | awk '{print $1}')

# Verify the SHA1 hash of the cron script in the system
if [ -f "/etc/cron.daily/aide" ]; then
    SYSTEM_HASH=$(sha1sum /etc/cron.daily/aide | awk '{print $1}')
elif [ -f "/etc/cron.monthly/aide" ]; then
    SYSTEM_HASH=$(sha1sum /etc/cron.monthly/aide | awk '{print $1}')
else
    echo "Error: No AIDE cron script found in /etc/cron.daily or /etc/cron.monthly. This is a finding."
    exit 1
fi

if [ "$ORIGINAL_HASH" != "$SYSTEM_HASH" ]; then
    echo "The AIDE cron script has been modified. Restoring the default script."
    sudo cp /tmp/original_aide_script /etc/cron.daily/aide
    sudo chmod +x /etc/cron.daily/aide
else
    echo "The AIDE cron script is unchanged and matches the original."
fi

# Clean up
rm -f /tmp/original_aide_script
echo "AIDE cron script verification and restoration complete."
