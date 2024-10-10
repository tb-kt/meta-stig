#!/bin/bash

# Description: This script configures Ubuntu 22.04 LTS to display the date and time of the last successful account logon upon logon.

PAM_LOGIN_FILE="/etc/pam.d/login"

# Backup the original PAM configuration file
if [ ! -f "${PAM_LOGIN_FILE}.bak" ]; then
    sudo cp "$PAM_LOGIN_FILE" "${PAM_LOGIN_FILE}.bak"
    echo "Backup of $PAM_LOGIN_FILE created at ${PAM_LOGIN_FILE}.bak"
fi

# Check if pam_lastlog is already configured correctly
if grep -q "pam_lastlog.so" "$PAM_LOGIN_FILE"; then
    echo "pam_lastlog is already configured in $PAM_LOGIN_FILE"
    # Update the configuration if necessary
    sudo sed -i '/pam_lastlog.so/s/.*/session     required     pam_lastlog.so     showfailed/' "$PAM_LOGIN_FILE"
    echo "pam_lastlog configuration updated in $PAM_LOGIN_FILE"
else
    echo "Configuring pam_lastlog in $PAM_LOGIN_FILE..."
    echo "session     required     pam_lastlog.so     showfailed" | sudo tee -a "$PAM_LOGIN_FILE"
    echo "pam_lastlog configuration added to $PAM_LOGIN_FILE"
fi
