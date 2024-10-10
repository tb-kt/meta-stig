#!/bin/bash

# Description: This script configures the group ownership of audit configuration files to "root".

AUDIT_FILES=(
    "/etc/audit/audit.rules"
    "/etc/audit/auditd.conf"
    "/etc/audit/rules.d/*"
)

# Iterate over the audit files and set the group ownership to root
for FILE in "${AUDIT_FILES[@]}"; do
    if [ -e "$FILE" ]; then
        echo "Setting group ownership for $FILE to root"
        sudo chown :root "$FILE" || {
            echo "Error: Failed to set group ownership for $FILE"
            exit 1
        }
    else
        echo "Warning: $FILE not found, skipping."
    fi
done

echo "Group ownership of audit configuration files set to root successfully."
