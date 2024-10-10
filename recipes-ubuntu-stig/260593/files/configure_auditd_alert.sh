#!/bin/bash

# Description: This script configures auditd to alert the ISSO and SA in case of an audit processing failure.

ADMIN_EMAIL="<administrator_email_account>"

# Check if the email package is installed
if ! dpkg -l | grep -q "mailutils"; then
    echo "Mail package is not installed. Installing mailutils..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y mailutils || {
            echo "Error: Failed to install mailutils via apt-get."
            exit 1
        }
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y mailx || {
            echo "Error: Failed to install mailx via dnf."
            exit 1
        }
    elif command -v yum &> /dev/null; then
        sudo yum install -y mailx || {
            echo "Error: Failed to install mailx via yum."
            exit 1
        }
    else
        echo "Unsupported package manager."
        exit 1
    fi
else
    echo "Mail package is already installed."
fi

# Configure auditd to alert SA and ISSO in case of an audit processing failure
echo "Configuring auditd to alert in case of an audit processing failure..."
sudo sed -i -E "s/^(action_mail_acct\s*=\s*).*/\1${ADMIN_EMAIL}/" /etc/audit/auditd.conf || {
    echo "Error: Failed to configure auditd alert email address."
    exit 1
}

# Restart auditd service to apply changes
echo "Restarting auditd service..."
sudo systemctl restart auditd.service || {
    echo "Error: Failed to restart auditd service."
    exit 1
}

echo "Auditd has been successfully configured to alert ${ADMIN_EMAIL} in the event of an audit processing failure."
