SUMMARY = "Set audit configuration files permissions to 640 to ensure they are not accessible by unauthorized users"
DESCRIPTION = "This recipe configures the audit configuration files on Ubuntu 22.04 LTS to have permissions set to 640, ensuring they are not write-accessible by unauthorized users."
LICENSE = "CLOSED"

SRC_URI = "file://set_audit_file_permissions.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/set_audit_file_permissions.sh ${D}${bindir}/set_audit_file_permissions.sh
}

FILES_${PN} += "${bindir}/set_audit_file_permissions.sh"

RDEPENDS_${PN} += "auditd"

# Run the script after installation to set audit file permissions
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/set_audit_file_permissions.sh || {
        echo "Failed to set permissions for audit configuration files"
        exit 1
    }
}
