#!/bin/sh

# Description: This script configures account identifiers to be disabled after 35 days of inactivity.

CONFIG_FILE="/etc/default/useradd"

set_inactive_days() {
    if grep -q "^INACTIVE=" "$CONFIG_FILE"; then
        # Update INACTIVE value if already present
        sed -i 's/^INACTIVE=.*/INACTIVE=35/' "$CONFIG_FILE"
    else
        # Add INACTIVE value if not present
        echo "INACTIVE=35" >> "$CONFIG_FILE"
    fi

    # Verify if the update was successful
    if grep -q "^INACTIVE=35" "$CONFIG_FILE"; then
        echo "INACTIVE value set to 35 days successfully."
    else
        echo "Failed to set INACTIVE value. Please check manually."
        exit 1
    fi
}

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

# Main function to check package manager and set inactivity days
main() {
    check_package_manager
    set_inactive_days
}

main
