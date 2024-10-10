#!/bin/bash

# Description: Configure audit rules to generate records for all account creations, modifications, disabling, and termination events affecting /etc/passwd.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Check if audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for /etc/passwd
echo "Adding audit rule for /etc/passwd..."
echo "-w /etc/passwd -p wa -k usergroup_modification" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

echo "Audit rule for /etc/passwd added successfully."
