SUMMARY = "Configure audit records for uses of chcon command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the chcon command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_chcon.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_chcon.sh ${D}${bindir}/audit_chcon.sh
}

FILES_${PN} += "${bindir}/audit_chcon.sh"

RDEPENDS_${PN} += "auditd coreutils"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_chcon.sh || {
        echo "Failed to configure audit rule for chcon"
        exit 1
    }
}
