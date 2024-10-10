#!/bin/sh

MODPROBE_CONF="/etc/modprobe.d/stig.conf"

# Function to append a line to a file if it doesn't already exist
append_if_not_exists() {
    local line="$1"
    local file="$2"
    grep -qF -- "$line" "$file" || echo "$line" >> "$file"
}

# Check if /etc/modprobe.d directory exists
if [ ! -d "/etc/modprobe.d" ]; then
    echo "/etc/modprobe.d directory does not exist. Please ensure you are using a compatible Linux distribution."
    exit 1
fi

# Disable USB mass storage driver by blacklisting and setting the install command to /bin/false
echo "Configuring system to disable USB mass storage driver..."

# Add or update the required lines in the configuration file
append_if_not_exists "install usb-storage /bin/false" "$MODPROBE_CONF"
append_if_not_exists "blacklist usb-storage" "$MODPROBE_CONF"

# Verify if the lines were correctly added
grep "usb-storage" "$MODPROBE_CONF" | grep "/bin/false" > /dev/null
if [ $? -eq 0 ]; then
    echo "Successfully disabled USB storage kernel module using '/bin/false'."
else
    echo "Failed to disable USB storage kernel module using '/bin/false'. Please check manually."
    exit 1
fi

grep "usb-storage" "$MODPROBE_CONF" | grep -i "blacklist" > /dev/null
if [ $? -eq 0 ]; then
    echo "Successfully blacklisted USB storage."
else
    echo "Failed to blacklist USB storage. Please check manually."
    exit 1
fi

echo "Script execution completed successfully."
