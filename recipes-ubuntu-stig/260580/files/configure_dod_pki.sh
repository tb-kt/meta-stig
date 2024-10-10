#!/bin/bash

# Description: This script configures Ubuntu 22.04 LTS to use DOD PKI-established certificate authorities.

DOD_CERT_CHAIN="DOD_PKE_CA_chain.pem"
CERTS_DIR="/etc/ssl/certs"
CA_CERTS_DIR="/usr/share/ca-certificates"
CERTS_SOURCE="/path/to/DOD/certificates"  # Adjust this path to the actual location of DOD certificates

# Ensure the source directory exists and contains the DOD certificate
if [ ! -d "$CERTS_SOURCE" ] || [ ! -f "$CERTS_SOURCE/$DOD_CERT_CHAIN" ]; then
    echo "Error: DOD certificate chain not found at $CERTS_SOURCE. Please provide the correct path."
    exit 1
fi

# Copy the DOD certificate to the CA certificates directory
echo "Copying DOD certificate to ${CA_CERTS_DIR}..."
sudo cp "$CERTS_SOURCE/$DOD_CERT_CHAIN" "$CA_CERTS_DIR/"

# Add the certificate to the list of trusted CA certificates
echo "Updating CA certificates configuration..."
if ! grep -q "$DOD_CERT_CHAIN" /etc/ca-certificates.conf; then
    echo "$DOD_CERT_CHAIN" | sudo tee -a /etc/ca-certificates.conf
fi

# Update the certificates in /etc/ssl/certs
echo "Updating /etc/ssl/certs directory..."
sudo dpkg-reconfigure ca-certificates

# Verify if the DOD root certificate is added successfully
if ls "$CERTS_DIR" | grep -qi "DOD"; then
    echo "DOD PKI-established certificate authority configured successfully."
else
    echo "Error: Failed to add the DOD PKI certificate authority."
    exit 1
fi
