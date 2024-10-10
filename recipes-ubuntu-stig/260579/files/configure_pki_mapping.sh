#!/bin/bash

# Description: This script configures Ubuntu 22.04 LTS to map the authenticated identity to the user or group account for PKI-based authentication.

# Configuration file path
PAM_PKCS11_CONF="/etc/pam_pkcs11/pam_pkcs11.conf"
EXAMPLE_CONF="/usr/share/doc/libpam-pkcs11/examples/pam_pkcs11.conf.example.gz"

# Check if the configuration file exists
if [ ! -f "$PAM_PKCS11_CONF" ]; then
    echo "Configuration file not found. Creating configuration from example..."
    # Check if example configuration exists and decompress it if necessary
    if [ -f "$EXAMPLE_CONF" ]; then
        sudo mkdir -p /etc/pam_pkcs11/
        sudo gzip -dc "$EXAMPLE_CONF" > "$PAM_PKCS11_CONF"
    else
        echo "Example configuration not found. Please make sure the package is installed properly."
        exit 1
    fi
fi

# Set "use_mappers" to include "pwent"
echo "Configuring use_mappers in $PAM_PKCS11_CONF"
if grep -q "use_mappers" "$PAM_PKCS11_CONF"; then
    echo "Updating existing use_mappers to include 'pwent'..."
    sudo sed -i 's|use_mappers = .*;|use_mappers = pwent;|' "$PAM_PKCS11_CONF"
else
    # Add use_mappers if it doesn't exist
    echo "Adding use_mappers configuration..."
    sudo sed -i '/pkcs11_module opensc {/,/}/ s|}|    use_mappers = pwent;\n}|' "$PAM_PKCS11_CONF"
fi

echo "PKI-based authentication mapping configuration is complete."
