#!/bin/bash

# Description: This script ensures only authorized users are part of the sudo group

check_and_remove_unauthorized_users() {
    # Get the list of users in the sudo group
    sudo_users=$(getent group sudo | cut -d: -f4 | tr ',' ' ')

    # Define authorized users (modify this list as needed)
    authorized_users=("admin" "secadmin")

    for user in $sudo_users; do
        if [[ ! " ${authorized_users[@]} " =~ " ${user} " ]]; then
            echo "Removing unauthorized user '$user' from sudo group..."
            sudo gpasswd -d "$user" sudo
        else
            echo "User '$user' is authorized."
        fi
    done
}

# Run the function to check and remove unauthorized users
check_and_remove_unauthorized_users

echo "Completed checking sudo group membership."
