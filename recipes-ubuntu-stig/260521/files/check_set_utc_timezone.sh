#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if the timedatectl command is available
if ! command_exists timedatectl; then
    echo "ERROR: timedatectl command not found. Please install systemd to proceed."
    exit 1
fi

# Check the current time zone
current_timezone=$(timedatectl status | grep -i "time zone" | awk '{print $3}')

if [ "$current_timezone" = "Etc/UTC" ]; then
    echo "The system time zone is already set to UTC."
else
    echo "The system time zone is not set to UTC. Setting time zone to UTC..."

    # Set the time zone to UTC
    timedatectl set-timezone Etc/UTC

    # Verify if the time zone was set correctly
    new_timezone=$(timedatectl status | grep -i "time zone" | awk '{print $3}')
    if [ "$new_timezone" = "Etc/UTC" ]; then
        echo "The system time zone has been successfully set to UTC."
    else
        echo "Failed to set the system time zone to UTC. Please check manually."
        exit 1
    fi
fi

echo "Script execution completed."
