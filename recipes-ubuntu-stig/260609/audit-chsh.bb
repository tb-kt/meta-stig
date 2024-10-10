SUMMARY = "Configure audit records for uses of chsh command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the chsh command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_chsh.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_chsh.sh ${D}${bindir}/audit_chsh.sh
}

FILES_${PN} += "${bindir}/audit_chsh.sh"

RDEPENDS_${PN} += "auditd coreutils"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_chsh.sh || {
        echo "Failed to configure audit rule for chsh"
        exit 1
    }
}
