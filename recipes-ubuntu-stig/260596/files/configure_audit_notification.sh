#!/bin/bash

# Description: This script configures auditd to notify the SA and ISSO when the audit record storage volume reaches 25% remaining capacity.

AUDITD_CONF="/etc/audit/auditd.conf"

# Configure space_left and space_left_action parameters
echo "Configuring auditd to notify SA and ISSO at 25% storage volume capacity..."
sudo sed -i -E "s/^\s*space_left\s*=.*/space_left = 25%/" ${AUDITD_CONF} || {
    echo "Error: Failed to configure space_left in ${AUDITD_CONF}"
    exit 1
}

sudo sed -i -E "s/^\s*space_left_action\s*=.*/space_left_action = email/" ${AUDITD_CONF} || {
    echo "Error: Failed to configure space_left_action in ${AUDITD_CONF}"
    exit 1
}

# Restart auditd service to apply changes
echo "Restarting auditd service..."
sudo systemctl restart auditd.service || {
    echo "Error: Failed to restart auditd service."
    exit 1
}

echo "Audit notification configuration completed successfully."
