#!/bin/bash

# Description: This script configures Ubuntu 22.04 LTS to encrypt all stored passwords using the FIPS 140-3-approved SHA512 algorithm.

CONFIG_FILE="/etc/login.defs"
KEYWORD="ENCRYPT_METHOD"
HASH_METHOD="SHA512"

# Check if the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file $CONFIG_FILE not found."
    exit 1
fi

# Backup existing configuration file
cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"

# Check if ENCRYPT_METHOD is already defined
grep -q "^$KEYWORD" "$CONFIG_FILE"
if [ $? -eq 0 ]; then
    # Update the line if it already exists
    sed -i "s/^$KEYWORD.*/$KEYWORD $HASH_METHOD/" "$CONFIG_FILE"
else
    # Add the configuration line if it doesn't exist
    echo "$KEYWORD $HASH_METHOD" >> "$CONFIG_FILE"
fi

echo "Password encryption method has been set to $HASH_METHOD."
