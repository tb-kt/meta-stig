#!/bin/bash

# Description: This script configures Ubuntu 22.04 LTS to limit the number of concurrent sessions to 10 for all accounts.

LIMITS_CONF="/etc/security/limits.conf"
LIMITS_D_DIR="/etc/security/limits.d"

# Backup the original limits.conf file if not already backed up
if [ ! -f "${LIMITS_CONF}.bak" ]; then
    sudo cp "$LIMITS_CONF" "${LIMITS_CONF}.bak"
    echo "Backup of $LIMITS_CONF created at ${LIMITS_CONF}.bak"
fi

# Update limits.conf to limit concurrent sessions to 10
if grep -q "^[^#]*hard[[:space:]]*maxlogins" "$LIMITS_CONF"; then
    # Update existing maxlogins setting
    sudo sed -i 's/^\([^#]*hard[[:space:]]*maxlogins[[:space:]]*\).*/\1 10/' "$LIMITS_CONF"
    echo "Updated maxlogins setting in $LIMITS_CONF"
else
    # Add maxlogins setting if it doesn't exist
    echo "* hard maxlogins 10" | sudo tee -a "$LIMITS_CONF"
    echo "Added maxlogins setting to $LIMITS_CONF"
fi

# Apply the same configuration to any file under /etc/security/limits.d/
for file in "$LIMITS_D_DIR"/*.conf; do
    if [ -f "$file" ]; then
        if grep -q "^[^#]*hard[[:space:]]*maxlogins" "$file"; then
            sudo sed -i 's/^\([^#]*hard[[:space:]]*maxlogins[[:space:]]*\).*/\1 10/' "$file"
            echo "Updated maxlogins setting in $file"
        else
            echo "* hard maxlogins 10" | sudo tee -a "$file"
            echo "Added maxlogins setting to $file"
        fi
    fi
done

echo "Concurrent session limit has been set to 10 for all accounts."
