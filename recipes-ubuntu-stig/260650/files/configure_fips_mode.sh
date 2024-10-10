#!/bin/bash

# Description: Configure Ubuntu 22.04 LTS to run in FIPS mode

# Check if FIPS is already enabled
FIPS_STATUS=$(cat /proc/sys/crypto/fips_enabled)
if [ "$FIPS_STATUS" -eq 1 ]; then
    echo "FIPS mode is already enabled."
    exit 0
fi

# Verify if Ubuntu Pro is available for FIPS
if ! command -v pro &> /dev/null; then
    echo "Ubuntu Pro is not installed. Please install Ubuntu Pro to enable FIPS."
    exit 1
fi

# Enable FIPS using Ubuntu Pro
echo "Enabling FIPS mode..."
sudo pro attach && sudo pro enable fips

# Add 'fips=1' to the kernel parameter
echo "Updating GRUB configuration to enable FIPS..."
sudo sed -i 's/GRUB_CMDLINE_LINUX="\(.*\)"/GRUB_CMDLINE_LINUX="\1 fips=1"/' /etc/default/grub

# Update GRUB
echo "Updating GRUB..."
sudo update-grub

echo "Reboot the system to apply the changes."
