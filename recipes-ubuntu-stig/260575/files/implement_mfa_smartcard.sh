#!/bin/bash

# Description: This script configures smart card login for multifactor authentication on Ubuntu 22.04 LTS

# Define configuration files
PAM_AUTH_FILE="/etc/pam.d/common-auth"
SSHD_CONFIG_FILE="/etc/ssh/sshd_config"

# Function to modify configuration files
configure_pam_pkcs11() {
    # Add or modify pam_pkcs11 configuration in /etc/pam.d/common-auth
    if grep -q "pam_pkcs11.so" $PAM_AUTH_FILE; then
        echo "Updating existing pam_pkcs11.so configuration..."
        sudo sed -i 's|^.*pam_pkcs11.so.*|auth     [success=2 default=ignore]     pam_pkcs11.so|' $PAM_AUTH_FILE
    else
        echo "Adding pam_pkcs11.so configuration..."
        echo "auth     [success=2 default=ignore]     pam_pkcs11.so" | sudo tee -a $PAM_AUTH_FILE
    fi
}

configure_sshd_pubkey_auth() {
    # Add or modify PubkeyAuthentication in /etc/ssh/sshd_config
    if grep -q "^PubkeyAuthentication" $SSHD_CONFIG_FILE; then
        echo "Updating existing PubkeyAuthentication configuration..."
        sudo sed -i 's|^PubkeyAuthentication.*|PubkeyAuthentication yes|' $SSHD_CONFIG_FILE
    else
        echo "Adding PubkeyAuthentication configuration..."
        echo "PubkeyAuthentication yes" | sudo tee -a $SSHD_CONFIG_FILE
    fi

    # Restart sshd to apply changes
    echo "Restarting sshd service..."
    sudo systemctl restart sshd
}

# Execute configuration functions
configure_pam_pkcs11
configure_sshd_pubkey_auth

echo "Smart card multifactor authentication configuration is complete."
