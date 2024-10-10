#!/bin/sh

# Enforce maximum password lifetime of 60 days for new user accounts

CONFIG_FILE="/etc/login.defs"

# Function to check and update PASS_MAX_DAYS
enforce_max_password_lifetime() {
    if grep -q "^PASS_MAX_DAYS" $CONFIG_FILE; then
        # Update PASS_MAX_DAYS to 60 if it's less than 60 or commented out
        sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS    60/' $CONFIG_FILE
    else
        # Add PASS_MAX_DAYS if it does not exist
        echo "PASS_MAX_DAYS    60" >> $CONFIG_FILE
    fi

    # Verify if the update was successful
    if grep -q "^PASS_MAX_DAYS.*60" $CONFIG_FILE; then
        echo "PASS_MAX_DAYS is set correctly to 60 (60-day maximum password lifetime)."
    else
        echo "Failed to set PASS_MAX_DAYS to 60. Please check manually."
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

# Check package manager and enforce maximum password lifetime
check_package_manager
enforce_max_password_lifetime
