#!/bin/bash

# Description: Configure PAM to prohibit the use of cached authentications after one day.

SSSD_CONF_FILE="/etc/sssd/sssd.conf"
SSSD_CONF_D_DIR="/etc/sssd/conf.d"
OFFLINE_CRED_LINE="offline_credentials_expiration = 1"

# Ensure that the SSSD configuration file exists
if [ ! -f "$SSSD_CONF_FILE" ] && [ ! -d "$SSSD_CONF_D_DIR" ]; then
    echo "Error: No valid SSSD configuration found. Please ensure SSSD is installed and configured properly."
    exit 1
fi

update_sssd_conf() {
    if ! grep -q "^$OFFLINE_CRED_LINE" "$1"; then
        echo "Updating $1 to prohibit cached authentications after one day."
        sudo sed -i '/^\[pam\]/a\'"$OFFLINE_CRED_LINE" "$1"
    else
        echo "$1 is already configured."
    fi
}

# Update /etc/sssd/sssd.conf if it exists
if [ -f "$SSSD_CONF_FILE" ]; then
    update_sssd_conf "$SSSD_CONF_FILE"
fi

# Update .conf files in /etc/sssd/conf.d if the directory exists
if [ -d "$SSSD_CONF_D_DIR" ]; then
    for conf_file in "$SSSD_CONF_D_DIR"/*.conf; do
        [ -e "$conf_file" ] || continue
        update_sssd_conf "$conf_file"
    done
fi

# Restart SSSD service to apply changes
echo "Restarting SSSD service..."
sudo systemctl restart sssd

echo "PAM configuration updated to prohibit the use of cached authentications after one day."
