#!/bin/bash

# Description: Configure audit rules to generate records for the /var/log/faillog file.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Check if audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for /var/log/faillog
echo "Adding audit rule for /var/log/faillog..."
echo "-w /var/log/faillog -p wa -k logins" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

echo "Audit rule for /var/log/faillog added successfully."
