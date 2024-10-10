#!/bin/bash

# Description: This script ensures that users are required to reauthenticate for privilege escalation or role change.

remove_nopasswd() {
    # Check for any occurrence of NOPASSWD or !authenticate in /etc/sudoers and /etc/sudoers.d
    echo "Checking for occurrences of NOPASSWD or !authenticate in /etc/sudoers and /etc/sudoers.d/*..."
    
    sudoers_files=$(grep -Elr '(NOPASSWD|!authenticate)' /etc/sudoers /etc/sudoers.d/* 2> /dev/null)

    if [[ ! -z "$sudoers_files" ]]; then
        echo "Removing occurrences of NOPASSWD and !authenticate..."
        for file in $sudoers_files; do
            echo "Modifying $file..."
            sudo sed -i '/NOPASSWD/d' "$file"
            sudo sed -i '/!authenticate/d' "$file"
        done
    else
        echo "No occurrences of NOPASSWD or !authenticate found."
    fi

    echo "Completed removing NOPASSWD and !authenticate."
}

# Run the function to remove NOPASSWD or !authenticate
remove_nopasswd

echo "Configuration completed to require reauthentication for privilege escalation."
