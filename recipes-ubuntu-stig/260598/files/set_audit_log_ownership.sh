#!/bin/bash

# Description: This script configures audit log files to be owned by the "root" user.

AUDITD_CONF="/etc/audit/auditd.conf"

# Get the path to the audit log file from auditd.conf
LOG_FILE=$(grep -iw "log_file" ${AUDITD_CONF} | awk -F "=" '{print $2}' | tr -d ' ')

if [ -z "$LOG_FILE" ]; then
    echo "Error: Could not determine audit log file path from ${AUDITD_CONF}."
    exit 1
fi

# Set ownership of audit log files to root
echo "Setting ownership of audit log files to root..."
sudo chown root "${LOG_FILE}" || {
    echo "Error: Failed to set ownership for ${LOG_FILE}."
    exit 1
}

echo "Audit log file ownership set successfully."
