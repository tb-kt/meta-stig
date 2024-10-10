#!/bin/sh

GSETTINGS_COMMAND="gsettings"
SCHEMA="org.gnome.desktop.screensaver"
KEY="lock-enabled"
VALUE="true"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if gsettings command exists and GNOME is installed
gsettings_installed() {
    if command_exists $GSETTINGS_COMMAND; then
        return 0
    else
        return 1
    fi
}

# Check if GNOME and gsettings are available
echo "Checking if GNOME and gsettings are available..."
if gsettings_installed; then
    echo "GNOME and gsettings are available."
else
    echo "gsettings is not available. Ensure GNOME is installed or install gsettings utility."
    exit 1
fi

# Set the lock-enabled setting to true
echo "Configuring GNOME screensaver settings to enable session lock..."
$GSETTINGS_COMMAND set $SCHEMA $KEY $VALUE

# Verify if the setting was correctly applied
current_value=$($GSETTINGS_COMMAND get $SCHEMA $KEY)

if [ "$current_value" = "$VALUE" ]; then
    echo "Session lock has been successfully enabled."
else
    echo "Failed to enable session lock. Please check the system settings manually."
    exit 1
fi

echo "Script execution completed."
