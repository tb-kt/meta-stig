#!/bin/bash

# Description: This script checks for accounts with blank or null passwords on Ubuntu 22.04 LTS and either locks them or prompts to set a password.

# File: /etc/shadow is used to determine which accounts have no password set.

# List accounts with blank passwords
echo "Checking for accounts with blank or null passwords..."
accounts=$(awk -F: '!$2 {print $1}' /etc/shadow)

if [ -z "$accounts" ]; then
    echo "No accounts with blank or null passwords found."
else
    echo "The following accounts have blank or null passwords:"
    echo "$accounts"
    for account in $accounts; do
        echo "Locking account: $account"
        sudo passwd -l $account
    done
    echo "All accounts with blank passwords have been locked. Set passwords manually for accounts if needed."
fi
