#!/bin/bash

# Description: This script enforces that at least eight characters must be changed when a password is updated.

PWQUALITY_CONF="/etc/security/pwquality.conf"

# Backup the original file
if [ ! -f "${PWQUALITY_CONF}.bak" ]; then
    cp "${PWQUALITY_CONF}" "${PWQUALITY_CONF}.bak"
fi

# Check and update the difok value
if grep -q "^difok" "$PWQUALITY_CONF"; then
    sed -i 's/^difok.*/difok = 8/' "$PWQUALITY_CONF"
else
    echo "difok = 8" | tee -a "$PWQUALITY_CONF" > /dev/null
fi

echo "Password change requirements enforced: at least eight characters must be different."
