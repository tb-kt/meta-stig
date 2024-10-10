#!/bin/bash

# Description: This script ensures that no accounts are allowed to have blank or null passwords on Ubuntu 22.04 LTS.

COMMON_PASSWORD_CONF="/etc/pam.d/common-password"

# Backup the original file if it doesn't already have a backup
if [ ! -f "${COMMON_PASSWORD_CONF}.bak" ]; then
    cp "${COMMON_PASSWORD_CONF}" "${COMMON_PASSWORD_CONF}.bak"
fi

# Ensure nullok is not present in the configuration file
if grep -q "nullok" "$COMMON_PASSWORD_CONF"; then
    sed -i '/nullok/d' "$COMMON_PASSWORD_CONF"
    echo "Removed instances of 'nullok' from $COMMON_PASSWORD_CONF to prevent blank passwords."
else
    echo "No instances of 'nullok' found in $COMMON_PASSWORD_CONF."
fi
