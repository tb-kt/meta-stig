#!/bin/bash

# Description: Configure audit rules to prevent all software from executing at higher privilege levels.

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

# Check if audit rules directory exists
if [ ! -d "/etc/audit/rules.d" ]; then
    echo "Audit rules directory does not exist, creating it."
    sudo mkdir -p /etc/audit/rules.d
fi

# Add audit rule for execve to audit privileged execution
echo "Adding audit rules for execve to audit privileged execution..."
{
    echo "-a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -k execpriv"
    echo "-a always,exit -F arch=b64 -S execve -C gid!=egid -F egid=0 -k execpriv"
    echo "-a always,exit -F arch=b32 -S execve -C uid!=euid -F euid=0 -k execpriv"
    echo "-a always,exit -F arch=b32 -S execve -C gid!=egid -F egid=0 -k execpriv"
} | sudo tee -a "$AUDIT_RULES_FILE" > /dev/null

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

echo "Audit rules for execve added successfully."
