#!/bin/bash

# Description: This script ensures rsyslog is installed, enabled, and active to preserve log records from failure events.

# Define variables
LOG_SERVICE="rsyslog"

# Check if rsyslog is installed
dpkg -l | grep -q $LOG_SERVICE
if [ $? -ne 0 ]; then
    echo "Installing $LOG_SERVICE..."
    sudo apt-get install -y $LOG_SERVICE || {
        echo "Error: Failed to install $LOG_SERVICE."
        exit 1
    }
else
    echo "$LOG_SERVICE is already installed."
fi

# Enable and activate the rsyslog service
echo "Enabling and starting $LOG_SERVICE service..."
sudo systemctl enable $LOG_SERVICE.service --now || {
    echo "Error: Failed to enable and start $LOG_SERVICE service."
    exit 1
}

# Verify the rsyslog service is enabled and active
if systemctl is-enabled $LOG_SERVICE.service | grep -q "enabled" && systemctl is-active $LOG_SERVICE.service | grep -q "active"; then
    echo "$LOG_SERVICE service is successfully enabled and active."
else
    echo "Error: $LOG_SERVICE service is not enabled and/or active."
    exit 1
fi
