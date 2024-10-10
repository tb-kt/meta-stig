#!/bin/sh

GSETTINGS_COMMAND="gsettings"
SCHEMA="org.gnome.settings-daemon.plugins.media-keys"
KEY="logout"
VALUE="@as []"

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

# Configure to disable the Ctrl-Alt-Delete key sequence
echo "Disabling Ctrl-Alt-Delete key sequence for graphical user interface..."
$GSETTINGS_COMMAND set $SCHEMA $KEY "$VALUE"

# Verify if the setting was correctly applied
current_value=$($GSETTINGS_COMMAND get $SCHEMA $KEY)

if [ "$current_value" = "$VALUE" ]; then
    echo "Ctrl-Alt-Delete key sequence has been successfully disabled."
else
    echo "Failed to disable Ctrl-Alt-Delete key sequence. Please check the system settings manually."
    exit 1
fi

# Update dconf settings
echo "Updating dconf settings..."
if command_exists dconf; then
    dconf update
    echo "dconf settings updated successfully."
else
    echo "dconf command not available. Make sure dconf is installed."
    exit 1
fi

echo "Script execution completed."
