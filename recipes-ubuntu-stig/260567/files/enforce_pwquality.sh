#!/bin/bash

# Description: This script enforces the use of pwquality for password complexity and retry limits on Ubuntu 22.04 LTS.

PWQUALITY_CONF="/etc/security/pwquality.conf"
COMMON_PASSWORD_CONF="/etc/pam.d/common-password"

# Backup the original files if they don't already have backups
if [ ! -f "${PWQUALITY_CONF}.bak" ]; then
    cp "${PWQUALITY_CONF}" "${PWQUALITY_CONF}.bak"
fi

if [ ! -f "${COMMON_PASSWORD_CONF}.bak" ]; then
    cp "${COMMON_PASSWORD_CONF}" "${COMMON_PASSWORD_CONF}.bak"
fi

# Ensure pwquality.conf enforces password complexity
if grep -q "^enforcing" "$PWQUALITY_CONF"; then
    sed -i 's/^enforcing.*/enforcing = 1/' "$PWQUALITY_CONF"
else
    echo "enforcing = 1" | tee -a "$PWQUALITY_CONF" > /dev/null
fi

# Ensure common-password uses pam_pwquality
if grep -q "pam_pwquality.so" "$COMMON_PASSWORD_CONF"; then
    sed -i 's/^password\s\+requisite\s\+pam_pwquality.so.*/password requisite pam_pwquality.so retry=3/' "$COMMON_PASSWORD_CONF"
else
    echo "password requisite pam_pwquality.so retry=3" | tee -a "$COMMON_PASSWORD_CONF" > /dev/null
fi

echo "pwquality configuration enforced for password changes and retry limit set to 3."
