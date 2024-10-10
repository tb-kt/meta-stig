#!/bin/sh

BANNER_FILE="/etc/issue.net"
SSH_CONFIG_FILE="/etc/ssh/sshd_config"
SSH_SERVICE="sshd"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if SSH is installed
ssh_installed() {
    if command_exists dpkg && dpkg -l | grep -qw openssh-server; then
        return 0
    elif command_exists dnf && rpm -q openssh-server; then
        return 0
    elif command_exists rpm && rpm -q openssh-server; then
        return 0
    else
        return 1
    fi
}

# Check if SSH is installed, if not install it
echo "Checking if SSH is installed..."
if ssh_installed; then
    echo "SSH is already installed on this system."
else
    echo "SSH is not installed. Installing SSH..."

    # Determine which package manager to use for installation
    if command_exists apt; then
        echo "Using apt system - Installing SSH..."
        apt-get update && apt-get install -y openssh-server
    elif command_exists dnf; then
        echo "Using dnf system - Installing SSH..."
        dnf install -y openssh-server
    elif command_exists rpm; then
        echo "Using rpm-based system - Installing SSH..."
        rpm -i openssh-server
    else
        echo "ERROR: No suitable package manager found. Please install SSH manually."
        exit 1
    fi

    # Verify if the installation was successful
    if ssh_installed; then
        echo "SSH has been successfully installed."
    else
        echo "Failed to install SSH. Please check manually."
        exit 1
    fi
fi

# Set the DOD banner
echo "Configuring the DOD banner..."

cat <<EOF > "$BANNER_FILE"
You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only. By using this IS (which includes any device attached to this IS), you consent to the following conditions:

-The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations.
-At any time, the USG may inspect and seize data stored on this IS.
-Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG-authorized purpose.
-This IS includes security measures (e.g., authentication and access controls) to protect USG interests--not for your personal benefit or privacy.
-Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details.
EOF

# Configure SSH to use the banner
echo "Configuring SSH to use the DOD banner..."

# Remove any existing Banner settings and add new one
sed -i '/^Banner/d' "$SSH_CONFIG_FILE"
echo "Banner $BANNER_FILE" >> "$SSH_CONFIG_FILE"

# Restart SSH service to apply changes
echo "Restarting SSH service..."
systemctl restart "$SSH_SERVICE"

# Verify if SSH service is running and enabled
echo "Checking if SSH service is enabled and running..."
ssh_enabled_status=$(systemctl is-enabled "$SSH_SERVICE" 2>/dev/null)
ssh_active_status=$(systemctl is-active "$SSH_SERVICE")

if [ "$ssh_enabled_status" != "enabled" ] || [ "$ssh_active_status" != "active" ]; then
    echo "SSH service is not enabled and/or running. Enabling and starting SSH service..."
    systemctl enable "$SSH_SERVICE" --now

    # Verify again
    ssh_enabled_status=$(systemctl is-enabled "$SSH_SERVICE" 2>/dev/null)
    ssh_active_status=$(systemctl is-active "$SSH_SERVICE")

    if [ "$ssh_enabled_status" = "enabled" ] && [ "$ssh_active_status" = "active" ]; then
        echo "SSH service has been successfully enabled and started."
    else
        echo "Failed to enable and start SSH service. Please check manually."
        exit 1
    fi
else
    echo "SSH service is already enabled and running."
fi

echo "Script execution completed."
