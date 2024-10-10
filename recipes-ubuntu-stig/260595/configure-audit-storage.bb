SUMMARY = "Configure auditd to allocate sufficient storage for audit records"
DESCRIPTION = "This recipe configures auditd to allocate storage capacity for at least one week's worth of audit records in Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

SRC_URI = "file://configure_audit_storage.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_audit_storage.sh ${D}${bindir}/configure_audit_storage.sh
}

FILES_${PN} += "${bindir}/configure_audit_storage.sh"

RDEPENDS_${PN} += "auditd"

# Run the script after installation to configure audit storage
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/configure_audit_storage.sh || {
        echo "Failed to configure audit storage"
        exit 1
    }
}
