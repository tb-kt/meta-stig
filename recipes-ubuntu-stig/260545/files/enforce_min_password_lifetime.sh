#!/bin/sh

# Enforce minimum password lifetime of 24 hours for new user accounts

CONFIG_FILE="/etc/login.defs"

# Function to check and update PASS_MIN_DAYS
enforce_min_password_lifetime() {
    if grep -q "^PASS_MIN_DAYS" $CONFIG_FILE; then
        # Update PASS_MIN_DAYS to 1 if it's less than 1 or commented out
        sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS    1/' $CONFIG_FILE
    else
        # Add PASS_MIN_DAYS if it does not exist
        echo "PASS_MIN_DAYS    1" >> $CONFIG_FILE
    fi

    # Verify if the update was successful
    if grep -q "^PASS_MIN_DAYS.*1" $CONFIG_FILE; then
        echo "PASS_MIN_DAYS is set correctly to 1 (24-hour minimum password lifetime)."
    else
        echo "Failed to set PASS_MIN_DAYS to 1. Please check manually."
        exit 1
    fi
}

# Function to check if the correct package manager is available
check_package_manager() {
    if command -v apt >/dev/null 2>&1; then
        echo "Using apt as package manager"
    elif command -v dnf >/dev/null 2>&1; then
        echo "Using dnf as package manager"
    elif command -v rpm >/dev/null 2>&1; then
        echo "Using rpm as package manager"
    else
        echo "No supported package manager found (apt, dnf, rpm)."
        exit 1
    fi
}

# Check package manager and enforce minimum password lifetime
check_package_manager
enforce_min_password_lifetime
