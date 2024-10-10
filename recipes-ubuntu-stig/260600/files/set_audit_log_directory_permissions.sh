#!/bin/bash

# Description: This script configures the audit log directory to ensure it has a mode of 750 or less permissive.

AUDITD_CONF="/etc/audit/auditd.conf"

# Get the directory path of the audit log file from auditd.conf
LOG_FILE=$(grep -iw "log_file" ${AUDITD_CONF} | awk -F "=" '{print $2}' | tr -d ' ')

if [ -z "$LOG_FILE" ]; then
    echo "Error: Could not determine audit log file path from ${AUDITD_CONF}."
    exit 1
fi

LOG_DIR=$(dirname "${LOG_FILE}")

# Set permissions of the audit log directory to 750 or less permissive
echo "Setting permissions of audit log directory to 750 or less..."
sudo chmod -R g-w,o-rwx "${LOG_DIR}" || {
    echo "Error: Failed to set permissions for ${LOG_DIR}."
    exit 1
}

echo "Audit log directory permissions set successfully."
