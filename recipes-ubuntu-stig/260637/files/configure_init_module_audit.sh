#!/bin/bash

# Description: Configure audit rules to generate records for successful/unsuccessful uses of the init_module and finit_module system calls.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Check if audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rules for init_module and finit_module system calls
echo "Adding audit rules for init_module and finit_module system calls..."
echo "-a always,exit -F arch=b32 -S init_module,finit_module -F auid>=1000 -F auid!=unset -k module_chng" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null
echo "-a always,exit -F arch=b64 -S init_module,finit_module -F auid>=1000 -F auid!=unset -k module_chng" | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

echo "Audit rules for init_module and finit_module added successfully."
