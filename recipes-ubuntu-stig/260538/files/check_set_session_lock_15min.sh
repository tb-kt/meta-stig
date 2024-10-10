#!/bin/sh

GSETTINGS_COMMAND="gsettings"
SCREENSAVER_SCHEMA="org.gnome.desktop.screensaver"
SESSION_SCHEMA="org.gnome.desktop.session"

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

# Configure session lock settings
echo "Configuring GNOME screensaver settings to enable session lock after 15 minutes of inactivity..."

# Set lock-enabled to true
$GSETTINGS_COMMAND set $SCREENSAVER_SCHEMA lock-enabled true

# Set lock-delay to 0 (immediate lock)
$GSETTINGS_COMMAND set $SCREENSAVER_SCHEMA lock-delay 0

# Set idle-delay to 900 seconds (15 minutes)
$GSETTINGS_COMMAND set $SESSION_SCHEMA idle-delay 900

# Verify if the settings were correctly applied
lock_enabled=$($GSETTINGS_COMMAND get $SCREENSAVER_SCHEMA lock-enabled)
lock_delay=$($GSETTINGS_COMMAND get $SCREENSAVER_SCHEMA lock-delay)
idle_delay=$($GSETTINGS_COMMAND get $SESSION_SCHEMA idle-delay)

if [ "$lock_enabled" = "true" ] && [ "$lock_delay" = "uint32 0" ] && [ "$idle_delay" = "uint32 900" ]; then
    echo "Session lock settings have been successfully applied."
else
    echo "Failed to apply session lock settings. Please check the system settings manually."
    exit 1
fi

echo "Script execution completed."
