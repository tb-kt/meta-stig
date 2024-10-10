SUMMARY = "Set audit log directory permissions to ensure it is not write-accessible by unauthorized users"
DESCRIPTION = "This recipe configures the audit log directory on Ubuntu 22.04 LTS to have permissions of 750 or less permissive, ensuring it is not write-accessible by unauthorized users."
LICENSE = "CLOSED"

SRC_URI = "file://set_audit_log_directory_permissions.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/set_audit_log_directory_permissions.sh ${D}${bindir}/set_audit_log_directory_permissions.sh
}

FILES_${PN} += "${bindir}/set_audit_log_directory_permissions.sh"

RDEPENDS_${PN} += "auditd"

# Run the script after installation to configure audit log directory permissions
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/set_audit_log_directory_permissions.sh || {
        echo "Failed to set audit log directory permissions"
        exit 1
    }
}
