#!/bin/bash

# Description: This script configures the audit system to generate audit records for the use of the chfn command.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Ensure the audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for chfn
echo "Adding audit rule for chfn command."
sudo tee -a "$AUDIT_RULES_FILE" > /dev/null <<EOL
-a always,exit -F path=/usr/bin/chfn -F perm=x -F auid>=1000 -F auid!=unset -k privileged-chfn
EOL

# Reload audit rules
echo "Reloading audit rules."
sudo augenrules --load

echo "Audit rule for chfn command added successfully."
