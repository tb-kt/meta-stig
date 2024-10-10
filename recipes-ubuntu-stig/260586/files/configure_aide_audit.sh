#!/bin/bash

# Description: This script configures AIDE to use cryptographic mechanisms to protect the integrity of audit tools.

# Function to install AIDE using apt
install_aide_apt() {
    echo "Installing AIDE using apt..."
    sudo apt update && sudo apt install -y aide aide-common
}

# Function to install AIDE using dnf
install_aide_dnf() {
    echo "Installing AIDE using dnf..."
    sudo dnf install -y aide
}

# Function to install AIDE using rpm
install_aide_rpm() {
    echo "Installing AIDE using rpm..."
    sudo rpm -i aide
}

# Determine the package manager and install AIDE
if [ -x "$(command -v apt)" ]; then
    install_aide_apt
elif [ -x "$(command -v dnf)" ]; then
    install_aide_dnf
elif [ -x "$(command -v rpm)" ]; then
    install_aide_rpm
else
    echo "Error: No supported package manager found (apt, dnf, rpm)."
    exit 1
fi

# Configure AIDE to protect the integrity of audit tools
AIDE_CONF="/etc/aide/aide.conf"

echo "Configuring AIDE to protect the integrity of audit tools..."

# Backup the original configuration file
if [ -f "$AIDE_CONF" ]; then
    sudo cp "$AIDE_CONF" "$AIDE_CONF.bak"
fi

# Add or modify the configuration to include cryptographic protection for audit tools
sudo bash -c "cat >> $AIDE_CONF << 'EOF'

# Audit Tools  
/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512  
/sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512  
/sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512  
/sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512  
/sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512  
/sbin/audispd p+i+n+u+g+s+b+acl+xattrs+sha512  
/sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512

EOF"

echo "AIDE configuration for audit tools integrity protection completed."

# Initialize AIDE
echo "Initializing AIDE (this may take a few minutes)..."
sudo aideinit

echo "AIDE audit tools integrity protection configuration complete."
