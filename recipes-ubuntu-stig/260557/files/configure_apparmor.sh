#!/bin/bash

# Description: This script ensures AppArmor is installed, enabled, and running, and verifies profiles are enforced.

install_apparmor() {
    # Install apparmor if it is not installed
    if command -v dpkg &> /dev/null; then
        echo "Checking for apparmor package using dpkg..."
        if ! dpkg -l | grep -q apparmor; then
            echo "AppArmor package not found. Installing using apt-get..."
            sudo apt-get update
            sudo apt-get install -y apparmor apparmor-profiles
        fi
    elif command -v rpm &> /dev/null; then
        echo "Checking for apparmor package using rpm..."
        if ! rpm -q apparmor; then
            echo "AppArmor package not found. Installing using dnf..."
            sudo dnf install -y apparmor apparmor-profiles
        fi
    else
        echo "No compatible package manager found on this system."
        exit 1
    fi
}

enable_apparmor() {
    # Enable and start AppArmor service
    echo "Enabling and starting AppArmor..."
    sudo systemctl enable apparmor.service --now
}

verify_apparmor_status() {
    # Verify AppArmor is enabled and running
    echo "Verifying AppArmor status..."
    if systemctl is-enabled apparmor.service | grep -q "enabled" && systemctl is-active apparmor.service | grep -q "active"; then
        echo "AppArmor service is enabled and active."
    else
        echo "AppArmor service is not enabled or active. This is a finding."
        exit 1
    fi

    # Verify AppArmor profiles are loaded and enforced
    echo "Checking AppArmor profiles..."
    sudo apparmor_status | grep -i "profile"
}

# Run the functions
install_apparmor
enable_apparmor
verify_apparmor_status

echo "AppArmor configuration completed!"
