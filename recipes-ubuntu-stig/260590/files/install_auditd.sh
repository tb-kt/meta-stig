#!/bin/bash

# Description: This script ensures the "auditd" package is installed on Ubuntu 22.04 LTS.

# Check if auditd is installed
if ! dpkg -l | grep -q auditd; then
    echo "auditd is not installed. Installing auditd..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y auditd || {
            echo "Error: Failed to install auditd via apt-get."
            exit 1
        }
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y audit || {
            echo "Error: Failed to install audit via dnf."
            exit 1
        }
    elif command -v yum &> /dev/null; then
        sudo yum install -y audit || {
            echo "Error: Failed to install audit via yum."
            exit 1
        }
    elif command -v rpm &> /dev/null; then
        echo "Package manager not detected. Please manually install auditd."
        exit 1
    else
        echo "Unsupported package manager."
        exit 1
    fi
else
    echo "auditd is already installed."
fi

# Enable and start auditd service
echo "Enabling and starting auditd service..."
sudo systemctl enable auditd.service --now || {
    echo "Error: Failed to enable and start auditd service."
    exit 1
}

# Verify that auditd service is active
if systemctl is-active auditd.service | grep -q "active"; then
    echo "auditd service is successfully active."
else
    echo "Error: auditd service is not active."
    exit 1
fi
