#!/bin/bash

# Description: This script enforces password complexity by requiring at least one lowercase character.

PWQUALITY_CONF="/etc/security/pwquality.conf"

# Backup the original file
if [ ! -f "${PWQUALITY_CONF}.bak" ]; then
    sudo cp "${PWQUALITY_CONF}" "${PWQUALITY_CONF}.bak"
fi

# Check and update the lcredit value
if grep -q "^lcredit" "$PWQUALITY_CONF"; then
    sudo sed -i 's/^lcredit.*/lcredit = -1/' "$PWQUALITY_CONF"
else
    echo "lcredit = -1" | sudo tee -a "$PWQUALITY_CONF" > /dev/null
fi

echo "Password complexity enforced: at least one lowercase character is required."
