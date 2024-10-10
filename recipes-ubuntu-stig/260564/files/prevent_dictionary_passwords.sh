#!/bin/bash

# Description: This script enforces password complexity by preventing the use of dictionary words.

PWQUALITY_CONF="/etc/security/pwquality.conf"

# Backup the original file
if [ ! -f "${PWQUALITY_CONF}.bak" ]; then
    sudo cp "${PWQUALITY_CONF}" "${PWQUALITY_CONF}.bak"
fi

# Check and update the dictcheck value
if grep -q "^dictcheck" "$PWQUALITY_CONF"; then
    sudo sed -i 's/^dictcheck.*/dictcheck = 1/' "$PWQUALITY_CONF"
else
    echo "dictcheck = 1" | sudo tee -a "$PWQUALITY_CONF" > /dev/null
fi

echo "Password dictionary check enforced: passwords cannot be dictionary words."
