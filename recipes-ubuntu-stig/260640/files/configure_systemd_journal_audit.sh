#!/bin/bash

# Description: Configure audit rules to generate records for events that affect systemd journal files.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Check if audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for systemd journal files
echo "Adding audit rule for systemd journal files..."
echo "-w /var/log/journal -p wa -k systemd_journal" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

echo "Audit rule for systemd journal files added successfully."
