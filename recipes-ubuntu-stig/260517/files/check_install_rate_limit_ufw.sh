#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if ufw is installed
ufw_installed() {
    if command_exists dpkg && dpkg -l | grep -qw ufw; then
        return 0
    elif command_exists dnf && rpm -q ufw; then
        return 0
    elif command_exists rpm && rpm -q ufw; then
        return 0
    else
        return 1
    fi
}

# Check if ufw is installed, if not install it
echo "Checking if Uncomplicated Firewall (ufw) is installed..."
if ufw_installed; then
    echo "ufw is already installed on this system."
else
    echo "ufw is not installed. Installing ufw..."

    # Determine which package manager to use for installation
    if command_exists apt; then
        echo "Using apt system - Installing ufw..."
        apt-get update && apt-get install -y ufw
    elif command_exists dnf; then
        echo "Using dnf system - Installing ufw..."
        dnf install -y ufw
    elif command_exists rpm; then
        echo "Using rpm-based system - Installing ufw..."
        rpm -i ufw
    else
        echo "ERROR: No suitable package manager found. Please install ufw manually."
        exit 1
    fi

    # Verify if the installation was successful
    if ufw_installed; then
        echo "ufw has been successfully installed."
    else
        echo "Failed to install ufw. Please check manually."
        exit 1
    fi
fi

# Enable ufw service if not already enabled
echo "Enabling ufw service if not already enabled..."
systemctl enable ufw.service --now

# Check if ufw is enabled
ufw_status=$(systemctl is-active ufw.service)
if [ "$ufw_status" != "active" ]; then
    echo "WARNING: Failed to enable ufw. Please enable it manually."
    exit 1
else
    echo "ufw service is enabled and running."
fi

# Check all listening services and configure ufw to rate limit them
echo "Configuring ufw to rate-limit all listening services..."
listening_ports=$(ss -l46ut | awk 'NR>1 {print $5}' | sed -e 's/.*://g' | sort -u | grep -v "*")

for port in $listening_ports; do
    if [ -n "$port" ]; then
        ufw_status=$(ufw status | grep -w "$port/tcp" | grep -w "LIMIT")
        if [ -z "$ufw_status" ]; then
            echo "Applying rate limit to port $port..."
            ufw limit "$port/tcp"
        else
            echo "Rate limit already applied to port $port."
        fi
    fi
done

echo "Script execution completed."
