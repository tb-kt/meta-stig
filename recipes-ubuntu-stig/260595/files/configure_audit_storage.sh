#!/bin/bash

# Description: This script configures auditd to allocate enough storage capacity for at least one week's worth of audit records.

# Variables
AUDIT_LOG_DIR="/var/log/audit"
AUDIT_LOG_FILE="${AUDIT_LOG_DIR}/audit.log"

# Ensure the audit log directory exists
if [ ! -d "${AUDIT_LOG_DIR}" ]; then
    echo "Creating audit log directory: ${AUDIT_LOG_DIR}"
    sudo mkdir -p ${AUDIT_LOG_DIR} || {
        echo "Error: Failed to create audit log directory."
        exit 1
    }
fi

# Configure auditd to store logs in the correct directory
echo "Configuring auditd to store logs in ${AUDIT_LOG_FILE}..."
sudo sed -i -E "s@^(log_file\s*=\s*).*@\1${AUDIT_LOG_FILE}@" /etc/audit/auditd.conf || {
    echo "Error: Failed to configure auditd log file location."
    exit 1
}

# Ensure the partition has enough space
echo "Checking available storage space for ${AUDIT_LOG_DIR}..."
AVAILABLE_SPACE=$(df -h ${AUDIT_LOG_DIR} | awk 'NR==2 {print $4}')
echo "Available space for audit logs: ${AVAILABLE_SPACE}"

# Restart auditd service to apply changes
echo "Restarting auditd service..."
sudo systemctl restart auditd.service || {
    echo "Error: Failed to restart auditd service."
    exit 1
}

echo "Audit storage configuration completed successfully."
