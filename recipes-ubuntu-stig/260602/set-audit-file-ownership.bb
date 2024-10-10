SUMMARY = "Set audit configuration files ownership to root to ensure they are owned by authorized users only"
DESCRIPTION = "This recipe configures the audit configuration files on Ubuntu 22.04 LTS to be owned by the root account, ensuring unauthorized users cannot modify the audit settings."
LICENSE = "CLOSED"

SRC_URI = "file://set_audit_file_ownership.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/set_audit_file_ownership.sh ${D}${bindir}/set_audit_file_ownership.sh
}

FILES_${PN} += "${bindir}/set_audit_file_ownership.sh"

RDEPENDS_${PN} += "auditd"

# Run the script after installation to set audit file ownership
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/set_audit_file_ownership.sh || {
        echo "Failed to set ownership for audit configuration files"
        exit 1
    }
}
