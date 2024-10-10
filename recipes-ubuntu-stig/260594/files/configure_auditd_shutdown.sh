#!/bin/bash

# Description: This script configures auditd to shut down by default upon audit failure.

# Configure auditd to shut down upon audit failure
echo "Configuring auditd to shut down upon audit failure..."
sudo sed -i -E "s/^(disk_full_action\s*=\s*).*/\1HALT/" /etc/audit/auditd.conf || {
    echo "Error: Failed to configure auditd shutdown action."
    exit 1
}

# Restart auditd service to apply changes
echo "Restarting auditd service..."
sudo systemctl restart auditd.service || {
    echo "Error: Failed to restart auditd service."
    exit 1
}

echo "Auditd has been successfully configured to shut down upon audit failure."
