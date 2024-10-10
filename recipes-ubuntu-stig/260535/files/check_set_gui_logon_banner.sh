#!/bin/sh

GDM_CONF_FILE="/etc/gdm3/greeter.dconf-defaults"
GDM_SERVICE="gdm3"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if GDM3 is installed
gdm3_installed() {
    if command_exists dpkg && dpkg -l | grep -qw gdm3; then
        return 0
    elif command_exists dnf && rpm -q gdm; then
        return 0
    elif command_exists rpm && rpm -q gdm; then
        return 0
    else
        return 1
    fi
}

# Check if GDM3 is installed, if not install it
echo "Checking if GDM3 is installed..."
if gdm3_installed; then
    echo "GDM3 is already installed on this system."
else
    echo "GDM3 is not installed. Installing GDM3..."

    # Determine which package manager to use for installation
    if command_exists apt; then
        echo "Using apt system - Installing GDM3..."
        apt-get update && apt-get install -y gdm3
    elif command_exists dnf; then
        echo "Using dnf system - Installing GDM3..."
        dnf install -y gdm
    elif command_exists rpm; then
        echo "Using rpm-based system - Installing GDM3..."
        rpm -i gdm
    else
        echo "ERROR: No suitable package manager found. Please install GDM3 manually."
        exit 1
    fi

    # Verify if the installation was successful
    if gdm3_installed; then
        echo "GDM3 has been successfully installed."
    else
        echo "Failed to install GDM3. Please check manually."
        exit 1
    fi
fi

# Configure graphical user logon banner to display DOD notice
echo "Configuring GDM to display DOD consent banner..."

# Ensure banner-message-enable is set to "true"
grep -q "^banner-message-enable" "$GDM_CONF_FILE" && sed -i 's/^banner-message-enable.*/banner-message-enable=true/' "$GDM_CONF_FILE" || echo "[org/gnome/login-screen]\nbanner-message-enable=true" >> "$GDM_CONF_FILE"

# Update GDM with the new configuration
echo "Updating GDM configuration..."
dconf update

# Restart GDM service to apply changes
echo "Restarting GDM service..."
systemctl restart "$GDM_SERVICE"

echo "Script execution completed."
