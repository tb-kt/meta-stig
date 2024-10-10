#!/bin/sh

MODPROBE_CONF="/etc/modprobe.d/stig.conf"

# Function to append a line to a file if it doesn't already exist
append_if_not_exists() {
    local line="$1"
    local file="$2"
    grep -qF -- "$line" "$file" || echo "$line" >> "$file"
}

# Check if /proc/net/wireless file exists and has wireless interfaces listed
if [ -f /proc/net/wireless ]; then
    if grep -q "wlan" /proc/net/wireless; then
        echo "Wireless interfaces detected."
    else
        echo "No wireless interfaces detected."
        exit 0
    fi
else
    echo "No wireless information available. Ensure the system supports wireless networking."
    exit 1
fi

# Disable all detected wireless network interfaces
echo "Disabling all wireless network interfaces..."
for iface in $(awk 'NR>2 {print $1}' /proc/net/wireless | sed 's/://'); do
    if command -v ifdown >/dev/null 2>&1; then
        ifdown $iface 2>/dev/null
    fi

    # Find module name associated with each wireless interface
    driver=$(basename $(readlink -f /sys/class/net/$iface/device/driver))
    if [ -n "$driver" ]; then
        # Disable the kernel module by blacklisting it
        append_if_not_exists "install $driver /bin/false" "$MODPROBE_CONF"
        echo "Wireless interface $iface using driver $driver has been disabled."

        # Remove the module from the system
        if command -v modprobe >/dev/null 2>&1; then
            modprobe -r $driver
        fi
    else
        echo "Unable to find driver for wireless interface $iface."
    fi
done

echo "All wireless network adapters have been disabled."
