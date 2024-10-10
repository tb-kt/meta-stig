#!/bin/bash

# Description: This script configures the audit system to generate audit records for the use of the ssh-keysign command.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Ensure the audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for ssh-keysign command
echo "Adding audit rule for ssh-keysign command."
sudo tee -a "$AUDIT_RULES_FILE" > /dev/null <<EOL
-a always,exit -F path=/usr/lib/openssh/ssh-keysign -F perm=x -F auid>=1000 -F auid!=unset -k privileged-ssh
EOL

# Reload audit rules
echo "Reloading audit rules."
sudo augenrules --load

echo "Audit rule for ssh-keysign command added successfully."
