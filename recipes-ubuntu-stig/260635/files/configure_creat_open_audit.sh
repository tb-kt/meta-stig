#!/bin/bash

# Description: Configure audit rules to generate records for successful/unsuccessful uses of creat, open, openat, open_by_handle_at, truncate, and ftruncate system calls.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Check if audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rules for creat, open, openat, open_by_handle_at, truncate, and ftruncate system calls
echo "Adding audit rules for creat, open, openat, open_by_handle_at, truncate, and ftruncate..."
echo "-a always,exit -F arch=b32 -S creat,open,openat,open_by_handle_at,truncate,ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=unset -k perm_access" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null
echo "-a always,exit -F arch=b32 -S creat,open,openat,open_by_handle_at,truncate,ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=unset -k perm_access" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null
echo "-a always,exit -F arch=b64 -S creat,open,openat,open_by_handle_at,truncate,ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=unset -k perm_access" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null
echo "-a always,exit -F arch=b64 -S creat,open,openat,open_by_handle_at,truncate,ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=unset -k perm_access" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

echo "Audit rules for creat, open, openat, open_by_handle_at, truncate, and ftruncate added successfully."
