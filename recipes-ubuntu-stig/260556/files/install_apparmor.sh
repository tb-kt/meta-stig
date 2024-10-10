#!/bin/bash

# Description: This script installs the "apparmor" package if it is not already installed.

install_apparmor() {
    if command -v dpkg &> /dev/null; then
        echo "Checking for apparmor package using dpkg..."
        if ! dpkg -l | grep -q apparmor; then
            echo "AppArmor package not found. Installing using apt-get..."
            sudo apt-get update
            sudo apt-get install -y apparmor
        else
            echo "AppArmor is already installed."
        fi
    elif command -v rpm &> /dev/null; then
        echo "Checking for apparmor package using rpm..."
        if ! rpm -q apparmor; then
            echo "AppArmor package not found. Installing using dnf..."
            sudo dnf install -y apparmor
        else
            echo "AppArmor is already installed."
        fi
    else
        echo "No compatible package manager found on this system."
    fi
}

# Run the function to install AppArmor
install_apparmor

echo "AppArmor installation check completed!"
