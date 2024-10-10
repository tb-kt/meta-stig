#!/bin/bash

# Description: Configure audit rules to generate records for successful/unsuccessful uses of unlink, unlinkat, rename, renameat, and rmdir system calls.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Check if audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rules for unlink, unlinkat, rename, renameat, and rmdir system calls
echo "Adding audit rules for unlink, unlinkat, rename, renameat, and rmdir system calls..."
echo "-a always,exit -F arch=b64 -S unlink,unlinkat,rename,renameat,rmdir -F auid>=1000 -F auid!=unset -k delete" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null
echo "-a always,exit -F arch=b32 -S unlink,unlinkat,rename,renameat,rmdir -F auid>=1000 -F auid!=unset -k delete" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

echo "Audit rules for unlink, unlinkat, rename, renameat, and rmdir added successfully."
