#!/bin/bash

# Description: Configure audit rules to generate records for modifications to the /etc/sudoers file.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Check if audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for /etc/sudoers
echo "Adding audit rule for /etc/sudoers..."
echo "-w /etc/sudoers -p wa -k privilege_modification" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

echo "Audit rule for /etc/sudoers added successfully."
