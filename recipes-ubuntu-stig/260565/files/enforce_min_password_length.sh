#!/bin/bash

# Description: This script enforces a minimum 15-character password length.

PWQUALITY_CONF="/etc/security/pwquality.conf"

# Backup the original file
if [ ! -f "${PWQUALITY_CONF}.bak" ]; then
    sudo cp "${PWQUALITY_CONF}" "${PWQUALITY_CONF}.bak"
fi

# Check and update the minlen value
if grep -q "^minlen" "$PWQUALITY_CONF"; then
    sudo sed -i 's/^minlen.*/minlen = 15/' "$PWQUALITY_CONF"
else
    echo "minlen = 15" | sudo tee -a "$PWQUALITY_CONF" > /dev/null
fi

echo "Minimum password length enforced: 15 characters."
