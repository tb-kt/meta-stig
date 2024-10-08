#!/bin/sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Verify if system partitions are encrypted using crypttab
if [ ! -f /etc/crypttab ]; then
    echo "/etc/crypttab not found. No encrypted partitions are configured."
    exit 1
fi

# Check the output of fdisk to get the partitions list
echo "Retrieving system partition information..."
fdisk_output=$(fdisk -l)

# Extract the persistent partitions from fdisk output
echo "Analyzing persistent partitions..."
persistent_partitions=$(echo "$fdisk_output" | grep '^/dev/' | awk '{print $1}')

# Check if each persistent partition has an entry in /etc/crypttab
missing_encryption=0
for partition in $persistent_partitions; do
    if ! grep -q "$partition" /etc/crypttab; then
        echo "WARNING: Persistent partition $partition is not listed in /etc/crypttab."
        missing_encryption=1
    fi
done

if [ $missing_encryption -eq 1 ]; then
    echo "Some persistent partitions are not encrypted. It is recommended to encrypt these partitions."
else
    echo "All persistent partitions are listed in /etc/crypttab and appear to be encrypted."
fi

echo "Script execution completed."
