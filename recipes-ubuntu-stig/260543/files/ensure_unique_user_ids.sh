#!/bin/sh

# Function to find duplicate UIDs
find_duplicate_uids() {
    awk -F ":" 'list[$3]++{print $1, $3}' /etc/passwd
}

# Function to assign unique UIDs
assign_unique_uids() {
    duplicate_uids=$(find_duplicate_uids)
    if [ -z "$duplicate_uids" ]; then
        echo "No duplicate UIDs found for interactive users."
    else
        echo "Duplicate UIDs found:"
        echo "$duplicate_uids"
        echo "Assigning unique UIDs..."

        for user in $(echo "$duplicate_uids" | awk '{print $1}'); do
            # Generate a new UID
            max_uid=$(awk -F ":" '{if ($3 >= 1000) print $3}' /etc/passwd | sort -n | tail -n 1)
            new_uid=$((max_uid + 1))

            # Assign the new UID
            echo "Assigning UID $new_uid to user $user"
            usermod -u $new_uid $user

            if [ $? -eq 0 ]; then
                echo "Successfully assigned new UID $new_uid to user $user."
            else
                echo "Failed to assign new UID to user $user. Please check manually."
                exit 1
            fi
        done
    fi
}

# Check for duplicate UIDs and assign unique ones if needed
assign_unique_uids
