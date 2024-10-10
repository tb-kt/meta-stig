#!/bin/bash

# Description: This script configures the audit system to generate audit records for the use of the pam_timestamp_check command.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Ensure the audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for pam_timestamp_check
echo "Adding audit rule for pam_timestamp_check command."
sudo tee -a "$AUDIT_RULES_FILE" > /dev/null <<EOL
-a always,exit -F path=/usr/sbin/pam_timestamp_check -F perm=x -F auid>=1000 -F auid!=unset -k privileged-pam_timestamp_check
EOL

# Reload audit rules
echo "Reloading audit rules."
sudo augenrules --load

echo "Audit rule for pam_timestamp_check command added successfully."
