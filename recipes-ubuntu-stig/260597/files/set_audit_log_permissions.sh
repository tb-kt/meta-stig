#!/bin/bash

# Description: This script configures audit log files to have a mode of "600" or less permissive.

AUDITD_CONF="/etc/audit/auditd.conf"

# Get the path to the audit log file from auditd.conf
LOG_FILE=$(grep -iw "log_file" ${AUDITD_CONF} | awk -F "=" '{print $2}' | tr -d ' ')

if [ -z "$LOG_FILE" ]; then
    echo "Error: Could not determine audit log file path from ${AUDITD_CONF}."
    exit 1
fi

# Set permissions of audit log files to 600
echo "Setting permissions of audit log files to 600..."
sudo chmod 600 "${LOG_FILE}" || {
    echo "Error: Failed to set permissions for ${LOG_FILE}."
    exit 1
}

echo "Audit log file permissions set successfully."
