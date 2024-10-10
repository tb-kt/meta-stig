SUMMARY = "Set audit log group to 'root' to ensure only authorized groups own audit log files"
DESCRIPTION = "This recipe configures the audit log group on Ubuntu 22.04 LTS to be 'root', ensuring only authorized groups own the audit log files."
LICENSE = "CLOSED"

SRC_URI = "file://set_audit_log_group.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/set_audit_log_group.sh ${D}${bindir}/set_audit_log_group.sh
}

FILES_${PN} += "${bindir}/set_audit_log_group.sh"

RDEPENDS_${PN} += "auditd"

# Run the script after installation to configure audit log group
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/set_audit_log_group.sh || {
        echo "Failed to set audit log group to 'root'"
        exit 1
    }
}
