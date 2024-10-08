#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if rsyslog is active and enabled
if command_exists systemctl && systemctl is-active --quiet rsyslog && systemctl is-enabled --quiet rsyslog; then
    echo "Rsyslog is active and enabled. This requirement is not applicable."
    exit 0
fi

# Check the permissions of /var/log
echo "Checking permissions for /var/log directory..."
current_permissions=$(stat -c "%a" /var/log)

if [ "$current_permissions" -le 755 ]; then
    echo "/var/log already has appropriate permissions ($current_permissions or less permissive)."
else
    echo "WARNING: /var/log has permissions that are too permissive ($current_permissions). Fixing permissions to 755..."
    chmod 0755 /var/log

    # Re-check permissions after fix
    new_permissions=$(stat -c "%a" /var/log)
    if [ "$new_permissions" -le 755 ]; then
        echo "Permissions for /var/log have been successfully corrected to 755."
    else
        echo "Failed to correct permissions for /var/log. Please check manually."
    fi
fi

echo "Script execution completed."
