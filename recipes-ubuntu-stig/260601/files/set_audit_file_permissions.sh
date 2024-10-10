#!/bin/bash

# Description: This script configures the audit configuration files to have appropriate permissions (640).

AUDIT_FILES=(
    "/etc/audit/audit.rules"
    "/etc/audit/auditd.conf"
    "/etc/audit/rules.d/*"
)

# Iterate over the audit files and set the permissions to 640
for FILE in "${AUDIT_FILES[@]}"; do
    if [ -e "$FILE" ]; then
        echo "Setting permissions for $FILE to 640"
        sudo chmod 640 "$FILE" || {
            echo "Error: Failed to set permissions for $FILE"
            exit 1
        }
    else
        echo "Warning: $FILE not found, skipping."
    fi
done

echo "Permissions for audit configuration files set successfully."
