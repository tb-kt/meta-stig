#!/bin/bash

# Description: This script enforces encrypted representations of passwords on Ubuntu 22.04 LTS.

COMMON_PASSWORD_CONF="/etc/pam.d/common-password"

# Backup the original file if it doesn't already have a backup
if [ ! -f "${COMMON_PASSWORD_CONF}.bak" ]; then
    cp "${COMMON_PASSWORD_CONF}" "${COMMON_PASSWORD_CONF}.bak"
fi

# Ensure common-password stores passwords in encrypted form
if grep -q "pam_unix.so" "$COMMON_PASSWORD_CONF"; then
    sed -i 's/^password\s\+.*pam_unix.so.*/password [success=1 default=ignore] pam_unix.so obscure sha512 shadow remember=5 rounds=5000/' "$COMMON_PASSWORD_CONF"
else
    echo "password [success=1 default=ignore] pam_unix.so obscure sha512 shadow remember=5 rounds=5000" | tee -a "$COMMON_PASSWORD_CONF" > /dev/null
fi

echo "Password encryption configuration updated in $COMMON_PASSWORD_CONF."
