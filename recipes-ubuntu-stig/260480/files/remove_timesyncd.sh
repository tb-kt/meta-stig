#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if systemd-timesyncd is installed
if command_exists systemctl && systemctl list-unit-files | grep -q systemd-timesyncd; then
    echo "systemd-timesyncd is installed. Proceeding with removal..."

    # Stop the service
    echo "Stopping systemd-timesyncd service..."
    systemctl stop systemd-timesyncd

    # Disable the service
    echo "Disabling systemd-timesyncd service..."
    systemctl disable systemd-timesyncd

    # Remove the package
    if command_exists apt; then
        echo "Removing systemd-timesyncd package..."
        apt purge systemd-timesyncd -y
    elif command_exists dnf; then
        echo "Removing systemd-timesyncd package..."
        dnf remove systemd-timesyncd -y
    else
        echo "Unable to determine package manager. Please remove systemd-timesyncd manually."
        exit 1
    fi

    # Remove configuration files
    echo "Removing configuration files..."
    rm -f /etc/systemd/timesyncd.conf
    rm -rf /etc/systemd/timesyncd.conf.d

    # Remove the systemd-timesync user and group
    echo "Removing systemd-timesync user and group..."
    userdel systemd-timesync
    groupdel systemd-timesync

    # Remove the clock file
    echo "Removing the clock file..."
    rm -f /var/lib/systemd/timesync/clock

    echo "systemd-timesyncd has been thoroughly removed from the system."
else
    echo "systemd-timesyncd is not installed on this system."
fi

echo "Script execution completed."
