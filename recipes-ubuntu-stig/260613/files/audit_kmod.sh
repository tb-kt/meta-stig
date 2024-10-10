#!/bin/bash

# Description: This script configures the audit system to generate audit records for the use of the kmod command.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Ensure the audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for kmod
echo "Adding audit rule for kmod command."
sudo tee -a "$AUDIT_RULES_FILE" > /dev/null <<EOL
-w /bin/kmod -p x -k modules
EOL

# Reload audit rules
echo "Reloading audit rules."
sudo augenrules --load

echo "Audit rule for kmod command added successfully."
