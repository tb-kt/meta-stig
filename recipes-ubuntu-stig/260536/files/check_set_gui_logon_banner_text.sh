#!/bin/sh

GDM_CONF_FILE="/etc/gdm3/greeter.dconf-defaults"
GDM_SERVICE="gdm3"
BANNER_TEXT="banner-message-text=\"You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only.\n\nBy using this IS (which includes any device attached to this IS), you consent to the following conditions:\n\n-The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations.\n\n-At any time, the USG may inspect and seize data stored on this IS.\n\n-Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG-authorized purpose.\n\n-This IS includes security measures (e.g., authentication and access controls) to protect USG interests--not for your personal benefit or privacy.\n\n-Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details.\""

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

# Configure graphical user logon banner text to display DOD notice
echo "Configuring GDM to display DOD consent banner..."

# Ensure banner-message-text is set correctly
grep -q "^banner-message-text" "$GDM_CONF_FILE" && sed -i "s|^banner-message-text.*|$BANNER_TEXT|" "$GDM_CONF_FILE" || echo -e "[org/gnome/login-screen]\n$BANNER_TEXT" >> "$GDM_CONF_FILE"

# Update GDM with the new configuration
echo "Updating GDM configuration..."
dconf update

# Restart GDM service to apply changes
echo "Restarting GDM service..."
systemctl restart "$GDM_SERVICE"

echo "Script execution completed."
