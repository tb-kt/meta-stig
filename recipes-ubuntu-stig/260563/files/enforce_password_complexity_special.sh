#!/bin/bash

# Description: This script enforces password complexity by requiring at least one special character.

PWQUALITY_CONF="/etc/security/pwquality.conf"

# Backup the original file
if [ ! -f "${PWQUALITY_CONF}.bak" ]; then
    sudo cp "${PWQUALITY_CONF}" "${PWQUALITY_CONF}.bak"
fi

# Check and update the ocredit value
if grep -q "^ocredit" "$PWQUALITY_CONF"; then
    sudo sed -i 's/^ocredit.*/ocredit = -1/' "$PWQUALITY_CONF"
else
    echo "ocredit = -1" | sudo tee -a "$PWQUALITY_CONF" > /dev/null
fi

echo "Password complexity enforced: at least one special character is required."
