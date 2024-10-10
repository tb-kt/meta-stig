#!/bin/bash

# Description: Configure audit rules to audit privileged activities and nonlocal maintenance sessions.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Check if audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for sudo.log to audit maintenance activities
echo "Adding audit rule for sudo.log to audit maintenance activities..."
{
    echo "-w /var/log/sudo.log -p wa -k maintenance"
} | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

echo "Audit rules for maintenance activities added successfully."
