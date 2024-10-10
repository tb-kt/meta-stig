#!/bin/bash

# Description: This script configures the audit log group to "root" to ensure that only authorized groups own the audit log files.

AUDITD_CONF="/etc/audit/auditd.conf"
LOG_GROUP_ENTRY="log_group = root"

# Check if the auditd.conf file exists
if [ ! -f "$AUDITD_CONF" ]; then
    echo "Error: $AUDITD_CONF does not exist."
    exit 1
fi

# Ensure log_group is set to root in auditd.conf
if grep -iq "^log_group" "$AUDITD_CONF"; then
    sudo sed -i -E "s/^log_group\s*=.*/${LOG_GROUP_ENTRY}/" "$AUDITD_CONF"
else
    echo "$LOG_GROUP_ENTRY" | sudo tee -a "$AUDITD_CONF"
fi

# Reload auditd to apply changes
echo "Reloading auditd configuration to apply changes..."
sudo systemctl kill auditd -s SIGHUP || {
    echo "Error: Failed to reload auditd configuration."
    exit 1
}

echo "Audit log group set to 'root' successfully."
