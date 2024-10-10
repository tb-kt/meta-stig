SUMMARY = "Set audit log file permissions to ensure they are not read- or write-accessible by unauthorized users"
DESCRIPTION = "This recipe configures audit log files on Ubuntu 22.04 LTS to have a mode of '600' or less permissive, ensuring they are not accessible by unauthorized users."
LICENSE = "CLOSED"

SRC_URI = "file://set_audit_log_permissions.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/set_audit_log_permissions.sh ${D}${bindir}/set_audit_log_permissions.sh
}

FILES_${PN} += "${bindir}/set_audit_log_permissions.sh"

RDEPENDS_${PN} += "auditd"

# Run the script after installation to configure audit log permissions
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/set_audit_log_permissions.sh || {
        echo "Failed to set audit log file permissions"
        exit 1
    }
}
