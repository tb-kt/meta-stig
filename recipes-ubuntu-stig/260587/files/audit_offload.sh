#!/bin/bash

# Description: This script offloads audit logs to external storage or network location weekly.

# Define variables
OFFLOAD_DIR="/mnt/external_audit_storage" # Path to external storage or network mount
AUDIT_LOG_DIR="/var/log/audit"
TIMESTAMP=$(date +%F)
BACKUP_FILE="audit_logs_${TIMESTAMP}.tar.gz"

# Check if the offload directory exists
if [ ! -d "$OFFLOAD_DIR" ]; then
    echo "Error: Offload directory $OFFLOAD_DIR does not exist."
    exit 1
fi

# Create an archive of the audit logs
echo "Archiving audit logs..."
tar -czf "/tmp/$BACKUP_FILE" "$AUDIT_LOG_DIR" || {
    echo "Error: Failed to create audit log archive."
    exit 1
}

# Move the archive to the external storage
echo "Offloading audit logs to external storage..."
mv "/tmp/$BACKUP_FILE" "$OFFLOAD_DIR" || {
    echo "Error: Failed to offload audit logs to $OFFLOAD_DIR."
    exit 1
}

echo "Audit logs successfully offloaded to $OFFLOAD_DIR/$BACKUP_FILE."
