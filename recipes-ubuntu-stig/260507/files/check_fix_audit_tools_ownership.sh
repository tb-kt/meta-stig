#!/bin/sh

# Audit tools to check ownership
audit_tools="/sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/audispd* /sbin/augenrules"

# Check if audit tools are owned by root
echo "Checking ownership for audit tools..."
for tool in $audit_tools; do
    for file in $(ls $tool 2>/dev/null); do
        if [ -e "$file" ]; then
            current_owner=$(stat -c "%U" "$file")
            if [ "$current_owner" != "root" ]; then
                echo "WARNING: $file is not owned by root. Current owner: $current_owner"
                
                # Fix the ownership to root
                echo "Fixing ownership to root for $file..."
                chown root "$file"

                # Re-check ownership after fix
                new_owner=$(stat -c "%U" "$file")
                if [ "$new_owner" = "root" ]; then
                    echo "Ownership for $file has been corrected to root."
                else
                    echo "Failed to correct ownership for $file. Please check manually."
                fi
            else
                echo "$file is already owned by root."
            fi
        else
            echo "$file does not exist on this system."
        fi
    done
done

echo "Script execution completed."
