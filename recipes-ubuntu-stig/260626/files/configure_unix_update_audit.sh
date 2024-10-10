#!/bin/bash

# Description: Configure audit rules to generate records for successful/unsuccessful uses of the unix_update command.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Check if audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for unix_update command
echo "Adding audit rule for unix_update command..."
echo "-a always,exit -F path=/sbin/unix_update -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

echo "Audit rule for unix_update command added successfully."
