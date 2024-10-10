#!/bin/bash

# Description: This script configures Ubuntu 22.04 LTS to enforce a delay of at least four seconds
# between logon prompts following a failed logon attempt.

PAM_AUTH_FILE="/etc/pam.d/common-auth"

# Check if pam_faildelay is already configured
if grep -q "pam_faildelay.so" "$PAM_AUTH_FILE"; then
    echo "pam_faildelay is already configured in $PAM_AUTH_FILE"
    # Update the delay value if necessary
    sudo sed -i '/pam_faildelay.so/s/delay=[0-9]\+/delay=4000000/' "$PAM_AUTH_FILE"
    echo "pam_faildelay delay value updated to 4000000 in $PAM_AUTH_FILE"
else
    echo "Configuring pam_faildelay in $PAM_AUTH_FILE..."
    echo "auth     required     pam_faildelay.so     delay=4000000" | sudo tee -a "$PAM_AUTH_FILE"
    echo "pam_faildelay configuration added to $PAM_AUTH_FILE"
fi
