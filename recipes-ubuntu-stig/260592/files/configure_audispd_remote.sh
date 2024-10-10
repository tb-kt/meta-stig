#!/bin/bash

# Description: This script configures the audit event multiplexor to offload audit logs to a remote server.

REMOTE_SERVER_IP="<remote_server_ip_address>"

# Install audispd-plugins if it is not already installed
if ! dpkg -l | grep -q audispd-plugins; then
    echo "audispd-plugins is not installed. Installing audispd-plugins..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y audispd-plugins || {
            echo "Error: Failed to install audispd-plugins via apt-get."
            exit 1
        }
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y audispd-plugins || {
            echo "Error: Failed to install audispd-plugins via dnf."
            exit 1
        }
    elif command -v yum &> /dev/null; then
        sudo yum install -y audispd-plugins || {
            echo "Error: Failed to install audispd-plugins via yum."
            exit 1
        }
    else
        echo "Unsupported package manager."
        exit 1
    fi
else
    echo "audispd-plugins is already installed."
fi

# Configure audisp-remote plugin as active
echo "Configuring audisp-remote plugin to be active..."
sudo sed -i -E 's/active\s*=\s*no/active = yes/' /etc/audit/plugins.d/au-remote.conf || {
    echo "Error: Failed to configure audisp-remote plugin as active."
    exit 1
}

# Set the IP address of the remote server
echo "Setting the remote server IP address..."
sudo sed -i -E "s/(remote_server\s*=).*/\1 ${REMOTE_SERVER_IP}/" /etc/audit/audisp-remote.conf || {
    echo "Error: Failed to set the remote server IP address."
    exit 1
}

# Restart auditd service
echo "Restarting auditd service..."
sudo systemctl restart auditd.service || {
    echo "Error: Failed to restart auditd service."
    exit 1
}

echo "Audit event multiplexor has been successfully configured to offload audit logs to ${REMOTE_SERVER_IP}."
