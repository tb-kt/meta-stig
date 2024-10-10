#!/bin/bash

# Description: This script installs the opensc-pkcs11 package to support PIV credentials on Ubuntu 22.04 LTS.

# Define the package
PACKAGE="opensc-pkcs11"

# Determine the package manager and install the package
if command -v apt-get >/dev/null 2>&1; then
    echo "Using apt-get to install the package..."
    sudo apt-get update && sudo apt-get install -y $PACKAGE
elif command -v dnf >/dev/null 2>&1; then
    echo "Using dnf to install the package..."
    sudo dnf install -y $PACKAGE
elif command -v yum >/dev/null 2>&1; then
    echo "Using yum to install the package..."
    sudo yum install -y $PACKAGE
else
    echo "Error: No supported package manager found (apt-get, dnf, yum)."
    exit 1
fi

# Verify installation
if dpkg -l | grep -q $PACKAGE; then
    echo "$PACKAGE successfully installed."
else
    echo "Error: Failed to install $PACKAGE."
    exit 1
fi
