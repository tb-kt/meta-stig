#!/bin/bash

# Description: This script configures Ubuntu 22.04 LTS to verify PIV credentials via OCSP.

# Configuration file
PAM_PKCS11_CONF="/etc/pam_pkcs11/pam_pkcs11.conf"

# Function to modify cert_policy configuration in pam_pkcs11.conf
configure_cert_policy() {
    echo "Configuring certificate policy in $PAM_PKCS11_CONF"

    # Check if cert_policy already exists in pam_pkcs11.conf
    if grep -q "cert_policy" $PAM_PKCS11_CONF; then
        echo "Updating existing cert_policy to enable ocsp_on..."
        sudo sed -i 's|cert_policy = .*;|cert_policy = ca,signature,ocsp_on;|' $PAM_PKCS11_CONF
    else
        # Add cert_policy if it doesn't exist
        echo "Adding cert_policy configuration..."
        sudo sed -i '/pkcs11_module opensc {/,/}/ s|}|    cert_policy = ca,signature,ocsp_on;\n}|' $PAM_PKCS11_CONF
    fi
}

# Execute configuration function
configure_cert_policy

echo "PIV credential verification configuration is complete."
