#!/bin/bash

# Description: This script configures Ubuntu 22.04 LTS for PKI-based authentication to validate certificates
# by constructing a certification path to an accepted trust anchor.

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

# Update cert_policy to ensure 'ca' is enabled
echo "Configuring certificate policy in $PAM_PKCS11_CONF"
if grep -q "cert_policy" "$PAM_PKCS11_CONF"; then
    echo "Updating existing cert_policy to include 'ca,signature,ocsp_on'..."
    sudo sed -i 's|cert_policy = .*;|cert_policy = ca,signature,ocsp_on;|' "$PAM_PKCS11_CONF"
else
    # Add cert_policy if it doesn't exist
    echo "Adding cert_policy configuration..."
    sudo sed -i '/pkcs11_module opensc {/,/}/ s|}|    cert_policy = ca,signature,ocsp_on;\n}|' "$PAM_PKCS11_CONF"
fi

echo "PKI-based authentication path validation configuration is complete."
