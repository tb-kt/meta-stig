#!/bin/bash

# Description: This script sets an expiration date for a temporary user account to expire after 72 hours.
# Usage: ./expire_temp_accounts.sh <temporary_account_name>

TEMP_ACCOUNT="$1"

if [ -z "$TEMP_ACCOUNT" ]; then
    echo "Usage: $0 <temporary_account_name>"
    exit 1
fi

# Check if the temporary account exists
if id "$TEMP_ACCOUNT" &>/dev/null; then
    # Set expiration date to 72 hours (3 days) from today
    EXPIRATION_DATE=$(date -d "+3 days" +%Y-%m-%d)
    sudo chage -E "$EXPIRATION_DATE" "$TEMP_ACCOUNT"

    # Verify if the expiration date has been set correctly
    EXPIRY_SET=$(sudo chage -l "$TEMP_ACCOUNT" | grep -E 'Account expires' | awk -F': ' '{print $2}')
    if [[ "$EXPIRY_SET" == "$EXPIRATION_DATE" ]]; then
        echo "Account '$TEMP_ACCOUNT' has been set to expire on $EXPIRATION_DATE"
    else
        echo "Failed to set expiration date for account '$TEMP_ACCOUNT'"
        exit 1
    fi
else
    echo "Account '$TEMP_ACCOUNT' does not exist"
    exit 1
fi
