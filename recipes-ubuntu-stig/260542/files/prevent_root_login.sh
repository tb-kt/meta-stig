#!/bin/sh

# Function to check if root login is locked
is_root_locked() {
    passwd -S root | grep -q " L "
}

# Disable direct root login
disable_root_login() {
    echo "Disabling direct root login..."
    passwd -l root
    if [ $? -eq 0 ]; then
        echo "Root login has been disabled successfully."
    else
        echo "Failed to disable root login. Please check manually."
        exit 1
    fi
}

# Check if root account is already locked
if is_root_locked; then
    echo "Root account is already locked."
else
    disable_root_login
fi
