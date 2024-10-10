#!/bin/bash

# Description: This script enforces password complexity by requiring at least one uppercase character.

PWQUALITY_CONF="/etc/security/pwquality.conf"

# Backup the original file
if [ ! -f "${PWQUALITY_CONF}.bak" ]; then
    sudo cp "${PWQUALITY_CONF}" "${PWQUALITY_CONF}.bak"
fi

# Check and update the ucredit value
if grep -q "^ucredit" "$PWQUALITY_CONF"; then
    sudo sed -i 's/^ucredit.*/ucredit = -1/' "$PWQUALITY_CONF"
else
    echo "ucredit = -1" | sudo tee -a "$PWQUALITY_CONF" > /dev/null
fi

echo "Password complexity enforced: at least one uppercase character is required."
