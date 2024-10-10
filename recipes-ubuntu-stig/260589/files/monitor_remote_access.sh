#!/bin/bash

# Description: This script ensures rsyslog is configured to monitor remote access methods on Ubuntu 22.04 LTS.

CONFIG_FILE="/etc/rsyslog.d/50-default.conf"

# Check if rsyslog is installed
if ! dpkg -l | grep -q rsyslog; then
    echo "rsyslog is not installed. Installing rsyslog..."
    sudo apt-get install -y rsyslog || {
        echo "Error: Failed to install rsyslog."
        exit 1
    }
else
    echo "rsyslog is already installed."
fi

# Ensure rsyslog configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file $CONFIG_FILE not found."
    exit 1
fi

# Update the rsyslog configuration to monitor remote access methods
echo "Configuring rsyslog to monitor remote access methods..."

sudo grep -qE '^(auth\.\*,authpriv\.\*|daemon\.\*)' "$CONFIG_FILE"
if [ $? -ne 0 ]; then
    sudo bash -c "cat <<EOF >> $CONFIG_FILE
# Monitor auth, authpriv, and daemon logs
auth.*,authpriv.* /var/log/secure
daemon.* /var/log/messages
EOF"
else
    echo "Configuration for monitoring remote access already exists in $CONFIG_FILE."
fi

# Restart rsyslog service
echo "Restarting rsyslog service..."
sudo systemctl restart rsyslog.service || {
    echo "Error: Failed to restart rsyslog service."
    exit 1
}

# Verify that rsyslog service is active
if systemctl is-active rsyslog.service | grep -q "active"; then
    echo "rsyslog service is successfully active."
else
    echo "Error: rsyslog service is not active."
    exit 1
fi
