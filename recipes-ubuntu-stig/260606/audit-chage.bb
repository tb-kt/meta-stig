SUMMARY = "Configure audit records for uses of chage command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the chage command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_chage.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_chage.sh ${D}${bindir}/audit_chage.sh
}

FILES_${PN} += "${bindir}/audit_chage.sh"

RDEPENDS_${PN} += "auditd shadow"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_chage.sh || {
        echo "Failed to configure audit rule for chage"
        exit 1
    }
}
