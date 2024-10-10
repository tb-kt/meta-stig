SUMMARY = "Set audit configuration files group ownership to root to ensure they are owned by authorized groups only"
DESCRIPTION = "This recipe configures the audit configuration files on Ubuntu 22.04 LTS to be owned by the root group, ensuring unauthorized groups cannot modify the audit settings."
LICENSE = "CLOSED"

SRC_URI = "file://set_audit_group_ownership.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/set_audit_group_ownership.sh ${D}${bindir}/set_audit_group_ownership.sh
}

FILES_${PN} += "${bindir}/set_audit_group_ownership.sh"

RDEPENDS_${PN} += "auditd"

# Run the script after installation to set audit file group ownership
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/set_audit_group_ownership.sh || {
        echo "Failed to set group ownership for audit configuration files"
        exit 1
    }
}
