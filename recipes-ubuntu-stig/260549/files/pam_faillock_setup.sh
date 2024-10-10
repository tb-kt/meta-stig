#!/bin/bash

# Description: This script configures Ubuntu 22.04 LTS to use the pam_faillock module to lock an account
# after three unsuccessful logon attempts until it is released by an administrator.

# Configure common-auth to use pam_faillock module
PAM_AUTH_FILE="/etc/pam.d/common-auth"
FAILLOCK_CONF_FILE="/etc/security/faillock.conf"

if grep -q "pam_faillock.so" "$PAM_AUTH_FILE"; then
    echo "pam_faillock is already configured in $PAM_AUTH_FILE"
else
    echo "Configuring pam_faillock in $PAM_AUTH_FILE..."
    sudo sed -i '/pam_unix.so/a auth     [default=die]  pam_faillock.so authfail\nauth     sufficient     pam_faillock.so authsucc' "$PAM_AUTH_FILE"
    echo "pam_faillock configuration added to $PAM_AUTH_FILE"
fi

# Configure faillock.conf with required options
echo "Configuring $FAILLOCK_CONF_FILE..."

sudo bash -c "cat > $FAILLOCK_CONF_FILE <<EOL
audit
silent
deny = 3
fail_interval = 900
unlock_time = 0
EOL"

echo "pam_faillock configuration completed in $FAILLOCK_CONF_FILE"
