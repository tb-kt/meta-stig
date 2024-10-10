#!/bin/bash

# Description: This script enforces password complexity by requiring at least one numeric character.

PWQUALITY_CONF="/etc/security/pwquality.conf"

# Backup the original file
if [ ! -f "${PWQUALITY_CONF}.bak" ]; then
    sudo cp "${PWQUALITY_CONF}" "${PWQUALITY_CONF}.bak"
fi

# Check and update the dcredit value
if grep -q "^dcredit" "$PWQUALITY_CONF"; then
    sudo sed -i 's/^dcredit.*/dcredit = -1/' "$PWQUALITY_CONF"
else
    echo "dcredit = -1" | sudo tee -a "$PWQUALITY_CONF" > /dev/null
fi

echo "Password complexity enforced: at least one numeric character is required."
